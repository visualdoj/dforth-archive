library dforth32;

uses
  {$I ..\DSlider\DSliderUnitsWithPath.inc},
  DForthStack,
  DForthMachine;

const
  DF_OK                         = 0;
  DF_R_UNDERFLOW                = 1;
  DF_R_OVERFLOW                 = 2;
  DF_W_UNDERFLOW                = 3;
  DF_W_OVERFLOW                 = 4;
  DF_C_OUT_OF_RANGE_ACCESS      = 5;

function dfCreateMachine: Pointer; stdcall;
begin
  Result := TForthMachine.Create;
end;

procedure dfFreeMachine(machine: Pointer); stdcall;
begin
  TForthMachine(machine).Free;
end;

procedure dfInterpret(machine: Pointer; code: PChar); stdcall;
var
  S: PChar;
begin
  GetMem(S, SizeOf(Char) * (Length(code) + 1));
  Move(code^, S^, SizeOf(Char) * (Length(code) + 1));
  TForthMachine(machine).Interpret(S);
  FreeMem(S);
end;

procedure dfSetUserData(machine: Pointer; userdata: Pointer); stdcall;
begin
  TForthMachine(machine).UserData := userdata;
end;

function dfGetUserData(machine: Pointer): Pointer; stdcall;
begin
  Result := TForthMachine(machine).UserData;
end;

function dfAddCommand(machine: Pointer; name: PChar; CallBack: Pointer): Pointer; stdcall;
begin
  TForthMachine(machine).AddCommand(name, TCallback(Callback));
end;

exports
  dfCreateMachine,
  dfFreeMachine,
  dfInterpret,
  dfSetUserData,
  dfGetUserData,
  dfAddCommand;

end.
