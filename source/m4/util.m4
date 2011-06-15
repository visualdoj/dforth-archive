define(`COMMENT',`dnl')
define(`CONCAT', `$1$2')

define(`_DS', `CONCAT($,*)')
define(`_D1', `CONCAT($,1)')
define(`_D2', `CONCAT($,2)')
define(`_D3', `CONCAT($,3)')
define(`_D4', `CONCAT($,4)')
define(`_D5', `CONCAT($,5)')
define(`_D6', `CONCAT($,6)')
define(`_D7', `CONCAT($,7)')
define(`_D8', `CONCAT($,8)')
define(`_D9', `CONCAT($,9)')

define(`M4LAMBDA',
`pushdef(`$0', patsubst(``$1'',`\$_\([0-9]*\)',`$\1'))$0(popdef(`$0')_$0')dnl
define(`_M4LAMBDA', `$@)')

dnl Добавление пробелов после каждой запятой в переданной строке
dnl Необходимо для $* парметров, в которых m4 все пробелы после запятых удаляет
define(`CS', `patsubst(`$*',`[,]',`, ')')

define(`DEFAULT',`ifelse($1,`',$2,$1)')

define(`NUMERATOR',`define(`$1_VALUE',DEFAULT(`$2',`0'))define(`$1',`$1_VALUE`'define(`$1_VALUE',incr($1_VALUE))')')

define(`DUP',`define(`$1',`$2')$1')

ifdef(`__windows__', `define(`_DATE_',`esyscmd(`dtime "ddd mmm dd h:n:s yyyy"')')', 
                     `define(`_DATE_',`')')
