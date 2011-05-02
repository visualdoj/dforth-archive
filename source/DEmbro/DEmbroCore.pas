unit DEmbroCore;

interface

const
  BOOL_FALSE                            = 0;
  BOOL_TRUE                             = -1;
  
  CELL_SIZE                             = SizeOf(Integer);

  OK                                    = 0;
  ERROR_EMBRO_NOT_ALIGNED_ALLOT         = 1;
  ERROR_EMBRO_TOO_BIG_ALLOT             = 2;
  ERROR_EMBRO_NOT_ALIGNED_CLEAR         = 3;
  ERROR_EMBRO_TOO_BIG_CLEAR             = 4;

  CR_windows: array[0..1] of Byte       = ( 13, 10 );  

type
  TError                                = Integer;
  TCell                                 = Integer; 
  TInt                                  = Integer;
  TUInt                                 = Cardinal;
  TPtr                                  = Pointer;

function Align(Value: Cardinal; _Unit: Cardinal = CELL_SIZE): Cardinal;

implementation

function Align;
var
  R: Cardinal;
begin
  R := Value mod _Unit;
  if R = 0 then
    Result := Value
  else
    Result := Value + _Unit - R;
end;

end.
