


















unit DCommandsOS;

interface

uses
  {$I units.inc},

  DForthMachine;



  procedure current_directory (Machine: TForthMachine; Command: PForthCommand);  

procedure LoadCommands(Machine: TForthMachine);

implementation

       procedure current_directory (Machine: TForthMachine; Command: PForthCommand);
       begin
         Machine.WUS(GetCurrentDirectory);
       end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('current-directory', current_directory);  
end;

end.
