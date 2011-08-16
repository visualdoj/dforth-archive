unit DCommandsXT;

interface

uses
  {$I units.inc},
  DCommandsStrings,
  strings,
  DForthMachine;

procedure LoadCommands(Machine: TForthMachine);

implementation

{$IFNDEF FLAG_FPC}{$REGION 'xt commands'}{$ENDIF}
procedure _xt_dot_name_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  str_push(Machine, TString(TXt(Machine.WOP).Name));
end;

procedure _xt_dot_asm_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUP(Pointer(@TXt(Machine.WOP)^.Code));
end;

procedure _xt_dot_code_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUP(Pointer(TXt(Machine.WOP)^.Data));
end;

procedure _xt_dot_flags_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(TUInt(TXt(Machine.WOP)^.Flags));
end;

procedure _xt_dot_param_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(TUInt(TXt(Machine.WOP)^.Param));
end;

procedure _xt_dot_name_ex(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  S := str_pop(Machine);
  TXt(Machine.WOP).Name := CreatePChar(@(S^.Sym[0]));
  DelRef(S);
end;

procedure _xt_dot_asm_ex(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Code := Machine.WOP;
end;

procedure _xt_dot_code_ex(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Data := Machine.WOP;
end;

procedure _xt_dot_flags_ex(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Flags := Machine.WOI;
end;

procedure _xt_dot_param_ex(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Param := Machine.WOP;
end;

procedure _aliased(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
  Name: TString;
  NewCommand: TXt;
begin
  X := Machine.WOP;
  Name := Machine.WOS;
  NewCommand := Machine.ReserveName(Name);
  NewCommand^.Code := X^.Code;
  NewCommand^.Data := X^.Data;
  NewCommand^.Param := X^.Param;
  NewCommand^.Flags := X^.Flags;
  Machine.OnUpdateCommand(NewCommand);
end;

procedure _alias(Machine: TForthMachine; Command: PForthCommand);
var
  X: TXt;
  Name: TString;
  NewCommand: TXt;
begin
  X := Machine.WOP;
  Name := Machine.NextName;
  NewCommand := Machine.ReserveName(Name);
  NewCommand^.Code := X^.Code;
  NewCommand^.Data := X^.Data;
  NewCommand^.Param := X^.Param;
  NewCommand^.Flags := X^.Flags;
  Machine.OnUpdateCommand(NewCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

procedure LoadCommands(Machine: TForthMachine);
begin
{$IFNDEF FLAG_FPC}{$REGION 'xt commands'}{$ENDIF}
  Machine.AddCommand('xt.name@', _xt_dot_name_dog);
  Machine.AddCommand('xt.asm@', _xt_dot_asm_dog);
  Machine.AddCommand('xt.code@', _xt_dot_code_dog);
  Machine.AddCommand('xt.flags@', _xt_dot_flags_dog);
  Machine.AddCommand('xt.param@', _xt_dot_param_dog);
  Machine.AddCommand('xt.name!', _xt_dot_name_ex);
  Machine.AddCommand('xt.asm!', _xt_dot_asm_ex);
  Machine.AddCommand('xt.code!', _xt_dot_code_ex);
  Machine.AddCommand('xt.flags!', _xt_dot_flags_ex);
  Machine.AddCommand('xt.param!', _xt_dot_param_ex);
  Machine.AddCommand('aliased', _aliased);
  Machine.AddCommand('alias', _alias);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}  
end;

end.
