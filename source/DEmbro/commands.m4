define(`all_implement', `')
define(`regist_all_commands', `')
define(`all_create', `')
define(`all_free', `')

define(`cmdhdr', `(Machine: TForthMachine; Command: PForthCommand)')
define(`WVar', `(Pointer(TUInt(Machine.WP) + ($1))^)')
define(`LVar', `(Pointer(TUInt(LB) + ($1))^)')
define(`WInc', `Inc(WP, $1)')
define(`WDec', `Dec(TUInt(WP), $1)')
define(`PSize', `(SizeOf(Pointer))')
define(`CELL', `(SizeOf(Pointer))')
define(`BInc', `Inc(BWP, CELL)')
define(`BDec', `Dec(TUInt(BWP), CELL)')
define(`BVar', `TBlock(Pointer(TUInt(Machine.BWP) + ($1)*CELL)^)')
define(`bAddRef', ` if $1 <> nil then begin
                   if PInteger($1)^ <> -1 then Inc(PInteger($1)^); 
                 end')
define(`bDelRef', ` if $1 <> nil then begin
                   if PInteger($1)^ > 1 then Dec(PInteger($1)^)
                   else if PInteger($1)^ = 1 then FreeMem(Pointer($1)); 
                 end')
define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
define(`body', `begin with Machine^ do begin $1 end; end;')
