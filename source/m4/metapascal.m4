define(`ASSERT',`if $1 then begin Log("assert error (__file__,__line__): not $1"); $2 end')
define(`IN',`ASSERT($1,Exit)')
define(`OUT',`ASSERT($1,)')

define(`RETURN',`begin ifelse($1,`',,Result := $1;) Exit; end')

define(`PROTOTYPE',`define($1,$2)') dnl PROTOTYPE(SomeFunc, function OnClick(Button: Integer): Boolean;)

define(`APPEND',`define(`$1',$1$2)')

define(`INIT',`begin ifelse($1,`',with $2,$1 := $2; with $1) do begin $3 end; end')

dnl define(`FOR',`for $1 := 0 to $2 - 1 do begin $3 end')
dnl define(`ARR',`FOR($1,)')
