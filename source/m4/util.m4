define(`CONCAT', `$1$2')

define(`M4LAMBDA',
`pushdef(`$0', patsubst(``$1'',`\$_\([0-9]*\)',`$\1'))$0(popdef(`$0')_$0')dnl
define(`_M4LAMBDA', `$@)')

dnl ���������� �������� ����� ������ ������� � ���������� ������
dnl ���������� ��� $* ���������, � ������� m4 ��� ������� ����� ������� �������
define(`CS', `patsubst(`$*',`[,]',`, ')')

define(`DEFAULT',`ifelse($1,`',$2,$1)')

define(`NUMERATOR',`define(`$1_VALUE',DEFAULT(`$2',`0'))define(`$1',`$1_VALUE`'define(`$1_VALUE',incr($1_VALUE))')')

define(`DUP',`define(`$1',`$2')$1')
