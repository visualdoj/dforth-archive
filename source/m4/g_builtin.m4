define(`GROUP',`m4 ../m4/cbuiltin.m4 commands/$1.cmd > temp/$1.de4
m4 id2.m4 temp/$1.de4 > ../../release/core/builtin/$1.de')
