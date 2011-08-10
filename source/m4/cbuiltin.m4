// This file has been generated automatically while DEmbro building

divert(`-1')
define(`MNEMONIC',`ifelse($2,`',$1,$2)')
define(`BOOL',`ifelse($1,`',False,$1)')

define(`DECLARE',`divert(`0')samebuiltin MNEMONIC($1,$2)
divert(`-1')')
