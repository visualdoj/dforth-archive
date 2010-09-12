function dfCreateMachine: Pointer; stdcall; external 'dforth32.dll';
procedure dfFreeMachine(machine: Pointer); stdcall; external 'dforth32.dll';
procedure dfInterpret(machine: Pointer; code: PChar); stdcall; external 'dforth32.dll';
procedure dfSetUserData(machine: Pointer; userdata: Pointer); stdcall; external 'dforth32.dll';
function dfGetUserData(machine: Pointer): Pointer; stdcall; external 'dforth32.dll';
function dfAddCommand(machine: Pointer; name: PChar; CallBack: Pointer): Pointer; stdcall; external 'dforth32.dll';

var
  Machine: Pointer;

procedure Callback(machine: Pointer); stdcall;
begin
  Writeln('CALLBACK!');
end;

begin
  Machine := dfCreateMachine;
  dfAddCommand(Machine, 'callback', @Callback);
  dfInterpret(Machine, '2 3 . . callback');
  dfFreeMachine(Machine);
end.
