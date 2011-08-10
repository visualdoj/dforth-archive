divert(`-1')
include(`..\m4\cutils.m4')

define(`DECLARE',`divert(`0')
procedure MNEMONIC($1,$2)(Machine: TForthMachine; Command: TXt); register;')

define(`SUMMARY',`divert(`-1')')
define(`DETAIL',`divert(`-1')')
define(`RUS',`divert(`-1')')
