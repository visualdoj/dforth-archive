divert(`-1')
include(`..\m4\cutils.m4')
define(`DECLARE',`divert(`0')AddCommand("$1", MNEMONIC($1,$2), BOOL($3));
divert(`-1')')
