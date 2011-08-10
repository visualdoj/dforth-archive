divert(`-1')
define(`MNEMONIC',`ifelse($2,`',$1,$2)')
define(`BOOL',`ifelse($1,`',False,$1)')

define(`DECLARE',`divert(`0')
procedure MNEMONIC($1,$2)(Machine: PForthMachine; Command: TXt); register;')

define(`SUMMARY',`divert(`-1')')
define(`DETAIL',`divert(`-1')')
define(`RUS',`divert(`-1')')
