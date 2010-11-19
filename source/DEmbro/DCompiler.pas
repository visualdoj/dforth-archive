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
  procedure UpdateCode;
  function Compile(Plugin: TPlugin): Boolean;
  procedure cOUTPUT(machine: TForthMachine; command: PForthCommand);
  procedure cCOMPILE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_GARBAGE(machine: TForthMachine; command: PForthCommand);
  procedure cPLUGINS(machine: TForthMachine; command: PForthCommand);
public
  constructor Create(Machine: TForthMachine);
  destructor Destroy; override;
end;

implementation

procedure TCompiler.UpdateCode;
var
  I: Integer;
begin
  with FMachine do begin
    Code.Count := Length(Chunks);
    Code.Chunks := @Chunks[0];
    for I := 0 to Code.Count - 1 do begin
      Chunks[I].Refs := @Refs[I][0];
      Chunks[I].Count := Length(Refs[I]);
    end;
    SetLength(Commands, Length(C));
    for I := 0 to High(C) do
      Commands[I].Name := C[I].Name;
  end;
end;

function TCompiler.Compile(Plugin: TPlugin): Boolean;
var
  Id, Pos: Integer;
begin
  Result := True;
  Plugin.SetParam(DEC_ID_APPTYPE, DEC_TYPE_INT, Pointer(FAppType));
  Plugin.SetParam(DEC_ID_OUTPUT, DEC_TYPE_STR, PChar(FOutPut));
  UpdateCode;
  Plugin.SetParam(DEC_ID_CODE, DEC_TYPE_DATA, @FMachine.Code, 0);
  Plugin.SetParam(DEC_ID_COMMANDS, DEC_TYPE_DATA, @FMachine.Commands[0], 
                                                  Length(FMachine.Commands));
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

procedure TCompiler.cOUTPUT(machine: TForthMachine; command: PForthCommand);
begin
  FOutput := machine.WOS;
end;

procedure TCompiler.cCOMPILE(machine: TForthMachine; command: PForthCommand);
var
  I: Integer;
begin
  for I := 0 to High(Plugins) do
    if Compile(Plugins[I]) then
      Break;
end;

procedure TCompiler.cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
begin
  FAppType := 1;
end;

procedure TCompiler.cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
begin
  FAppType := 2;
end;

procedure TCompiler.cAPPTYPE_GARBAGE(machine: TForthMachine; command: PForthCommand);
begin
  FAppType := 5679;
end;

procedure TCompiler.cPLUGINS(machine: TForthMachine; command: PForthCommand);
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
