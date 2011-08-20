DECLARE(xt.n@, xt_dot_n)
    body(
      Pointer(WVar(-SizeOf(Pointer))) := @(PForthCommand(WVar(-SizeOf(Pointer))).Name[0]);)

DECLARE(xt.d@, xt_dot_d)
    body(
      Pointer(WVar(-SizeOf(Pointer))) := PForthCommand(WVar(-SizeOf(Pointer))).Data)

DECLARE(xt.name@, xt_dot_name_dog)
begin
  str_push(Machine, TString(TXt(Machine.WOP).Name));
end;

DECLARE(xt.asm@, xt_dot_asm_dog)
begin
  Machine.WUP(Pointer(@TXt(Machine.WOP)^.Code));
end;

DECLARE(xt.code@, xt_dot_code_dog)
begin
  Machine.WUP(Pointer(TXt(Machine.WOP)^.Data));
end;

DECLARE(xt.flags@, xt_dot_flags_dog)
begin
  Machine.WUI(TUInt(TXt(Machine.WOP)^.Flags));
end;

DECLARE(xt.param@, xt_dot_param_dog)
begin
  Machine.WUI(TUInt(TXt(Machine.WOP)^.Param));
end;

DECLARE(xt.name!, xt_dot_name_ex)
var
  S: TStr;
begin
  S := str_pop(Machine);
  TXt(Machine.WOP).Name := CreatePChar(@(S^.Sym[0]));
  DelRef(S);
end;

DECLARE(xt.asm!, xt_dot_asm_ex)
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Code := Machine.WOP;
end;

DECLARE(xt.code!, _xt_dot_code_ex)
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Data := Machine.WOP;
end;

DECLARE(xt.flags!, _xt_dot_flags_ex)
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Flags := Machine.WOI;
end;

DECLARE(xt.param!, _xt_dot_param_ex)
var
  X: TXt;
begin
  X := Machine.WOP;
  X^.Param := Machine.WOP;
end;

DECLARE(aliased)
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

DECLARE(alias)
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
