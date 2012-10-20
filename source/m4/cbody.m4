divert(`-1')
include(`../m4/cutils.m4')
include(`../m4/c_header.m4')

define(`DECLARE',`divert(`0')
procedure MNEMONIC($1,$2)(Machine: TForthMachine; Command: TXt); register;')

define(`NOTATION',`divert(`-1')')
define(`SUMMARY',`divert(`-1')')
define(`DETAIL',`divert(`-1')')
define(`RUS',`divert(`-1')')

dnl Исходник на языке паскаль
define(`PASCAL',`ON')
define(`ENDPASCAL',`OFF')
define(`pascal',`PASCAL $* ENDPASCAL')

dnl Исходник для i386 ассемблера
define(`ASMI386',`ON idle(asm')
define(`ENDASMI386',`ON end;) OFF')
define(`asmi386',`ASMI386 $* ENDASMI386')

