divert(`-1')
define(`MNEMONIC',`ifelse($2,`',$1,$2)')
define(`BOOL',`ifelse($1,`',False,$1)')
define(`DECLARE',`divert(`0')LoadCommands(Machine, "MNEMONIC($1,$2)", BOOL($3));
divert(`-1')')
