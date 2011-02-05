unit DCompiler;

interface

uses
  DForthMachine,
  DPlugin,
  DUtils;

type
TCompiler = class
private
  FMachine: TForthMachine;
  FAppType: Integer;
  FOutput: TString;
public
  constructor Create(Machine: TForthMachine);
  destructor Destroy; override;
end;

  procedure UpdateCode(Machine: TForthMachine);
  function Compile(Machine: TForthMachine; Plugin: TPlugin): Boolean;
  procedure cOUTPUT(machine: TForthMachine; command: PForthCommand);
  procedure cCOMPILE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_GARBAGE(machine: TForthMachine; command: PForthCommand);
  procedure cPLUGINS(machine: TForthMachine; command: PForthCommand);

implementation

procedure UpdateCode;
var
  I: Integer;
begin
  with Machine^ do begin
    Code.Count := Length(Chunks);
    Code.Chunks := @Chunks[0];
    for I := 0 to Code.Count - 1 do begin
      Chunks[I].Refs := @Refs[I][0];
      Chunks[I].Count := Length(Refs[I]);
    end;
    SetLength(Commands, Length(C));
    for I := 0 to High(C) do begin
      Commands[I].Name := C[I].Name;
      Commands[I].Flags := Ord(IsImmediate(C[I]));
      Commands[I].Flags := Commands[I].Flags or (Ord(IsBuiltIn(C[I])) shl 1);
      Commands[I].Code := Cardinal(C[I].Data);
      Commands[I].Data := Cardinal(C[I].Param);
    end;
  end;
end;

function Compile(Machine: TForthMachine; Plugin: TPlugin): Boolean;
var
  Id, Pos: Integer;
begin
  Result := True;
  Plugin.SetParam(DEC_ID_APPTYPE, DEC_TYPE_INT, Pointer(Machine.FAppType));
  Plugin.SetParam(DEC_ID_OUTPUT, DEC_TYPE_STR, PChar(Machine.FOutPut));
  UpdateCode(Machine);
  Plugin.SetParam(DEC_ID_CODE, DEC_TYPE_DATA, @Machine.Code, 0);
  Plugin.SetParam(DEC_ID_COMMANDS, DEC_TYPE_DATA, @Machine.Commands[0], 
                                                  Length(Machine.Commands));
  Plugin.Compile;
  if Plugin.Ready <> 0 then begin
    Writeln('Compilation error [', Plugin.Name, '] plugin failed with error', Plugin.Ready);
    Result := False;
    Exit;
  end;
  while (Plugin.Error(Id, Pos) <> 0) and (Plugin.Ready = 0) do begin
    Writeln('Compilation error [', Plugin.Name, '] at ', Pos, ': ', 
            Plugin.ErrorString(Id), '');
    Result := False;
  end;
end;

procedure cOUTPUT(machine: TForthMachine; command: PForthCommand);
begin
  Machine.FOutput := machine.WOS;
end;

procedure cCOMPILE(machine: TForthMachine; command: PForthCommand);
var
  I: Integer;
begin
  for I := 0 to High(Plugins) do
    if Compile(Machine, Plugins[I]) then
      Break;
end;

procedure cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
begin
  Machine.FAppType := 1;
end;

procedure cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
begin
  Machine.FAppType := 2;
end;

procedure cAPPTYPE_GARBAGE(machine: TForthMachine; command: PForthCommand);
begin
  Machine.FAppType := 5679;
end;

procedure cPLUGINS(machine: TForthMachine; command: PForthCommand);
var
  I: Integer;
begin
  for I := 0 to High(Plugins) do
    Writeln(Plugins[I].Name, '   ');
end;

constructor TCompiler.Create(Machine: TForthMachine);
begin
  FMachine := Machine;
  Machine.AddCommand('cCOMPILE', cCOMPILE);
  Machine.AddCommand('cOUTPUT', cOUTPUT);
  Machine.AddCommand('cAPPTYPE-CONSOLE', cAPPTYPE_CONSOLE);
  Machine.AddCommand('cAPPTYPE-GUI', cAPPTYPE_GUI);
  Machine.AddCommand('cAPPTYPE-GARBAGE', cAPPTYPE_GARBAGE);
  Machine.AddCommand('cPLUGINS', cPLUGINS);
end;

destructor TCompiler.Destroy;
begin
end;

initialization
  LoadPlugins;
finalization
end.
