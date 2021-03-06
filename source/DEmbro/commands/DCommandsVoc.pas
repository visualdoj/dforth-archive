


















unit DCommandsVoc;

interface

uses
  DVocabulary,
  DForthMachine;
  
  procedure _vocabulary(Machine: TForthMachine; Command: PForthCommand);
  procedure _voc_dot_share(Machine: TForthMachine; Command: PForthCommand);
  procedure _vLOCAL(Machine: TForthMachine; Command: PForthCommand);
  procedure _vGLOBAL(Machine: TForthMachine; Command: PForthCommand);
  procedure _vBUILTIN(Machine: TForthMachine; Command: PForthCommand);
  procedure _TargetPush(Machine: TForthMachine; Command: PForthCommand);
  procedure _TargetPop(Machine: TForthMachine; Command: PForthCommand);
  procedure _ContextPush(Machine: TForthMachine; Command: PForthCommand);
  procedure _ContextPop(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _vocabulary(Machine: TForthMachine; Command: PForthCommand);
var
  V: PVoc;
begin
  with Machine^ do begin
    New(V);
    V^.Item := nil;
    V^.sFIND := -1;
    V^.sNOTFOUND := -1;
    V^.sCOMPILE_NOTFOUND := -1;
    WUP(V);
  end;
end;

procedure _voc_dot_share(Machine: TForthMachine; Command: PForthCommand);
var
  V: PVoc;
  I: PVocItem;
begin
  V := Machine.WOP;
  I := V^.Item;
  while I <> nil do begin
    Machine.AddToContext(I^.Index);
    I := I^.Next;
  end;
  Machine.UpdateContext;
end;

procedure _vLOCAL(Machine: TForthMachine; Command: PForthCommand);
begin 
  with Machine^ do begin
    WUP(vLOCAL);
  end;
end;

procedure _vGLOBAL(Machine: TForthMachine; Command: PForthCommand);
begin 
  with Machine^ do begin
    WUP(vGLOBAL);
  end;
end;

procedure _vBUILTIN(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine^.WUP(Machine^.vBUILTIN);
end;

procedure _TargetPush(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    TargetPush(WOP);
  end;
end;

procedure _TargetPop(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    WUP(TargetPop);
  end;
end;

procedure _ContextPush(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    ContextPush(WOP);
  end;
end;

procedure _ContextPop(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    WUP(ContextPop);
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('vocabulary-new', _vocabulary);
  Machine.AddCommand('voc.share', _voc_dot_share);
  Machine.AddCommand('vLOCAL', _vLOCAL);
  Machine.AddCommand('vGLOBAL', _vGLOBAL);
  Machine.AddCommand('vBUILTIN', _vBUILTIN);
  Machine.AddCommand('target<', _TargetPush);
  Machine.AddCommand('target>', _TargetPop);
  Machine.AddCommand('context<', _ContextPush);
  Machine.AddCommand('context>', _ContextPop);
end;

end.
