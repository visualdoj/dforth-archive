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
  procedure cOUTPUT(machine: TForthMachine; command: PForthCommand);
  procedure cCOMPILE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
  procedure cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
  procedure cPLUGINS(machine: TForthMachine; command: PForthCommand);
public
  constructor Create(Machine: TForthMachine);
  destructor Destroy; override;
end;

implementation

procedure TCompiler.cOUTPUT(machine: TForthMachine; command: PForthCommand);
begin
  FOutput := machine.WOS;
end;

procedure TCompiler.cCOMPILE(machine: TForthMachine; command: PForthCommand);
begin
end;

procedure TCompiler.cAPPTYPE_CONSOLE(machine: TForthMachine; command: PForthCommand);
begin
  FAppType := 1;
end;

procedure TCompiler.cAPPTYPE_GUI(machine: TForthMachine; command: PForthCommand);
begin
  FAppType := 2;
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
  Machine.AddCommand('cCOMPILE', cCOMPILE);
  Machine.AddCommand('cOUTPUT', cOUTPUT);
  Machine.AddCommand('cAPPTYPE-CONSOLE', cAPPTYPE_CONSOLE);
  Machine.AddCommand('cAPPTYPE-GUI', cAPPTYPE_GUI);
  Machine.AddCommand('cPLUGINS', cPLUGINS);
end;

destructor TCompiler.Destroy;
begin
end;

initialization
  LoadPlugins;
finalization
end.
