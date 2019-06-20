include(`blogspot.m4')dnl

Упростил процедуру добавления команд в ядро DEmbro.

Допустим, что я хочу добавить группу команд QUOTE(file), в которую входят MONO(fopen), MONO(fclose), MONO(fwrite) и MONO(fread).

BOLD(Как это было раньше)
Заходим в директорию MONO(source\DEmbro\commands), создаём там файл MONO(DCommandsFile.pas4), в нём пишем паскалевский модуль, в котором реализуем все команды. 

Создаём в модуле публичную функцию LoadCommands, в которой добавляем каждую команду в ядро (при помощи функции AddCommand).

Далее, заходим в главный файл проекта MONO(source\DEmbro\dembro32.dpr), в разделе MONO(uses) добавляем подключение нового модуля.

Теперь, заходим в MONO(source\DEmbro\DForthMachine.pas4), в приватной секции MONO(uses) тоже прописываем новый модуль. В методе MONO(OForthMachine.Create) того же файла добавляем строку MONO(DCommandsFile.LoadCommands(@Self);).

В этот момент команда появилась в ядре дембро, проект можно компилировать. Чтобы при стандартном запуске дембро эти команды были видны, нужно проделать ещё пару шагов.

Заходим в MONO(core\release\default), создаём файл MONO(file.de), в нём при помощи команды MONO(samebuiltin) прописываем подключаемые команды.

В файле MONO(core\release\default\system.de) прописываем
MONO(str" core\default\file.de" evaluate-file)

Теперь всё сделано. За исключением того, что ещё желательно писать хелп для каждой команды. Ужас, не правда ли?

BOLD(Как это будет теперь)
Заходим в MONO(source\DEmbro\commands), создаём файл MONO(file.cmd), в нём реализуем команды в таком виде:

DECLARE(fopen)
&nbsp;&nbsp;&nbsp;&nbsp;body( code for open );
RUS SUMMARY ( i B: s -- f) открывает файл по имени с заданными флагами

DECLARE(fclose)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for close);
RUS SUMMARY ( f --) закрывает файл, открытый ранее при помощи команды fopen

DECLARE(fread)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for read);
RUS SUMMARY ( pif --) читает i байт в область памяти p из файла f

DECLARE(fwrite)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for write);
RUS SUMMARY ( pif --) записывает i байт из области памяти p из файла f

Далее, в файле MONO(source\DEmbro\commands\groups.list) добавляем строку MONO(GROUP(file)).

Теперь в директории MONO(source\DEmbro) можно выполнить MONO(make commands) и команды будут автоматически разнесены по всем нужным файлам, остаётся только скомпилировать ядро.

BOLD(Как это работает)
Файлы MONO(*.cmd) и MONO(groups.list) обрабатываются при помощи MONO(m4) в несколько проходов, каждый раз предварительно подгружаются разные библиотеки. Библиотеки распологаются в LINK(http://code.google.com/p/dforth/source/browse/#svn%2Ftrunk%2Fsource%2Fm4, source\m4) и начинаются с буквы QUOTE(c) (от слова commands).

Например, чтобы сгенерировать список подключения команд в ядре, используется LINK(http://code.google.com/p/dforth/source/browse/trunk/source/m4/cload.m4, cload.m4) в следующей команде
&nbsp;&nbsp;&nbsp;&nbsp;MONO(m4 ..\m4\cload.m4 temp\all.cmd > temp\load.inc4)

Сгенерированный файл MONO(load.inc4) выглядит примерно так:
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("malloc", _malloc, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("free", _free, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("realloc", _realloc, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("move", _move, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("fill", _fill, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("current-directory", _current_directory, False);

А если проделать то же самое, но подключать LINK(http://code.google.com/p/dforth/source/browse/trunk/source/m4/cbuiltin.m4, cbuiltin.m4), то получим файл вида LINK(http://code.google.com/p/dforth/source/browse/trunk/release/core/builtin/mem.de, mem.de).

Аналогичным образом строятся другие файлы, а в будущем будут строиться хелпы. Напоследок приведу текущий код скрипта, раскидывающий команды (таргет commands в главном makefile):
MONO(&nbsp;&nbsp;&nbsp;&nbsp;type commands\mem.cmd commands\misc.cmd > temp\all.cmd
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cgroups.m4 commands\groups.list > temp\all.cmd
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cload.m4 temp\all.cmd > temp\load.inc4
&nbsp;&nbsp;&nbsp;&nbsp;m4 commands.m4 temp\load.inc4 > temp\load.incq
&nbsp;&nbsp;&nbsp;&nbsp;dquotes temp\load.incq load.inc
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cbody.m4 temp\all.cmd > temp\body.inc4
&nbsp;&nbsp;&nbsp;&nbsp;m4 commands.m4 temp\body.inc4 > temp\body.incq
&nbsp;&nbsp;&nbsp;&nbsp;dquotes temp\body.incq body.inc
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cevaluate.m4 commands\groups.list > ..\..\release\core\builtin\all.de
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cbuiltin.m4 commands\mem.cmd > ..\..\release\core\builtin\mem.de
&nbsp;&nbsp;&nbsp;&nbsp;m4 ..\m4\cbuiltin.m4 commands\misc.cmd > ..\..\release\core\builtin\misc.de)
