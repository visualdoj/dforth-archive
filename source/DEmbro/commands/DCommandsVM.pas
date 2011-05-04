


















unit DCommandsVM;

interface



uses
  DForthMachine;

  procedure vm_step (Machine: TForthMachine; Command: PForthCommand);  

procedure LoadCommands(Machine: TForthMachine);

implementation

       procedure vm_step (Machine: TForthMachine; Command: PForthCommand);
       begin
         Writeln('vm-step');
         Machine.Step;
       end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('vm-step', vm_step);  
end;

end.
