include(`blogspot.m4')dnl

�������� ��������� ���������� ������ � ���� DEmbro.

��������, ��� � ���� �������� ������ ������ QUOTE(file), � ������� ������ MONO(fopen), MONO(fclose), MONO(fwrite) � MONO(fread).

BOLD(��� ��� ���� ������)
������� � ���������� MONO(source\DEmbro\commands), ������ ��� ���� MONO(DCommandsFile.pas4), � �� ����� ������������ ������, � ������� ��������� ��� �������. 

������ � ������ ��������� ������� LoadCommands, � ������� ��������� ������ ������� � ���� (��� ������ ������� AddCommand).

�����, ������� � ������� ���� ������� MONO(source\DEmbro\dembro32.dpr), � ������� MONO(uses) ��������� ����������� ������ ������.

������, ������� � MONO(source\DEmbro\DForthMachine.pas4), � ��������� ������ MONO(uses) ���� ����������� ����� ������. � ������ MONO(OForthMachine.Create) ���� �� ����� ��������� ������ MONO(DCommandsFile.LoadCommands(@Self);).

� ���� ������ ������� ��������� � ���� ������, ������ ����� �������������. ����� ��� ����������� ������� ������ ��� ������� ���� �����, ����� ��������� ��� ���� �����.

������� � MONO(core\release\default), ������ ���� MONO(file.de), � �� ��� ������ ������� MONO(samebuiltin) ����������� ������������ �������.

� ����� MONO(core\release\default\system.de) �����������
MONO(str" core\default\file.de" evaluate-file)

������ �� �������. �� ����������� ����, ��� ��� ���������� ������ ���� ��� ������ �������. ����, �� ������ ��?

BOLD(��� ��� ����� ������)
������� � MONO(source\DEmbro\commands), ������ ���� MONO(file.cmd), � �� ��������� ������� � ����� ����:

DECLARE(fopen)
&nbsp;&nbsp;&nbsp;&nbsp;body( code for open );
RUS SUMMARY ( i B: s -- f) ��������� ���� �� ����� � ��������� �������

DECLARE(fclose)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for close);
RUS SUMMARY ( f --) ��������� ����, �������� ����� ��� ������ ������� fopen

DECLARE(fread)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for read);
RUS SUMMARY ( pif --) ������ i ���� � ������� ������ p �� ����� f

DECLARE(fwrite)
 &nbsp;&nbsp;&nbsp;&nbsp; body( code for write);
RUS SUMMARY ( pif --) ���������� i ���� �� ������� ������ p �� ����� f

�����, � ����� MONO(source\DEmbro\commands\groups.list) ��������� ������ MONO(GROUP(file)).

������ � ���������� MONO(source\DEmbro) ����� ��������� MONO(make commands) � ������� ����� ������������� ��������� �� ���� ������ ������, ������� ������ �������������� ����.

BOLD(��� ��� ��������)
����� MONO(*.cmd) � MONO(groups.list) �������������� ��� ������ MONO(m4) � ��������� ��������, ������ ��� �������������� ������������ ������ ����������. ���������� ������������� � LINK(http://code.google.com/p/dforth/source/browse/#svn%2Ftrunk%2Fsource%2Fm4, source\m4) � ���������� � ����� QUOTE(c) (�� ����� commands).

��������, ����� ������������� ������ ����������� ������ � ����, ������������ LINK(http://code.google.com/p/dforth/source/browse/trunk/source/m4/cload.m4, cload.m4) � ��������� �������
&nbsp;&nbsp;&nbsp;&nbsp;MONO(m4 ..\m4\cload.m4 temp\all.cmd > temp\load.inc4)

��������������� ���� MONO(load.inc4) �������� �������� ���:
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("malloc", _malloc, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("free", _free, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("realloc", _realloc, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("move", _move, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("fill", _fill, False);
&nbsp;&nbsp;&nbsp;&nbsp;AddCommand("current-directory", _current_directory, False);

� ���� ��������� �� �� �����, �� ���������� LINK(http://code.google.com/p/dforth/source/browse/trunk/source/m4/cbuiltin.m4, cbuiltin.m4), �� ������� ���� ���� LINK(http://code.google.com/p/dforth/source/browse/trunk/release/core/builtin/mem.de, mem.de).

����������� ������� �������� ������ �����, � � ������� ����� ��������� �����. ���������� ������� ������� ��� �������, ������������� ������� (������ commands � ������� makefile):
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
