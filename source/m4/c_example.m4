divert(`-1')
dnl Пример преобразования файла команд

dnl Макрос включения вывода
define(`ON',`divert(`0')')

dnl Макрос отключения фич
define(`OFF',`divert(`-1')')

dnl Имя команды DEmbro хранится в GLOBAL_NAME
define(`GLOBAL_NAME', `')

dnl Имя команды для ядра в паскале хранится в GLOBAL_SAFENAME
define(`GLOBAL_SAFENAME', `')

dnl В первую очередь определяем макрос объявления команд
define(`DECLARE',`OFF
  define(`GLOBAL_NAME', `$1')
  define(`GLOBAL_SAFENAME', `ifelse($2,`',_$1,_$2)')
  ON DECLARE_ACTION OFF')
define(`ENDDECLARE',`ON
OFF')

dnl Любую команду ниже можно отключить вызовом
dnl define(`MAKROSNAME', `OFF')
dnl По умолчанию все команды отключены

dnl То, что вызывается сразу после DECLARE
define(`DECLARE_ACTION',`There is declaration of command GLOBAL_NAME (GLOBAL_SAFENAME)')

dnl Depracated
define(`RUS',`OFF')
define(`SUMMARY',`OFF')
define(`DETAIL',`OFF')

dnl Исходник на языке паскаль
define(`PASCAL',`ON')
define(`ENDPASCAL',`OFF')
define(`pascal',`PASCAL $* ENDPASCAL')

dnl Исходник для i386 ассемблера
define(`ASMI386',`ON idle(asm')
define(`ENDASMI386',`ON end;) OFF')
define(`asmi386',`ASMI386 $* ENDASMI386')

dnl Русская документация на команду
define(`RUS',`ON Краткое описание: $*')
define(`ENDRUS', `OFF')

dnl Английская документация на команду
define(`ENG',`ON There is summary: $*')
define(`ENDENG', `OFF')

dnl Документация на команду на эсперанто ;)
define(`EPO',`ON Mallonga priskribo: $*')
define(`ENDEPO',`OFF')

dnl Отключаем вывод
OFF
