unit DVocabulary;

interface

{
        vocabulary xxx                  создать новый словарь
        xxx                             положить в стек созданный ранее словарь
        voc.use ( v-)                   dup voc.push voc.target !
        ^^^                             voc.pop voc.top voc.target !
        voc.target> ( v-)     
        voc.>target ( v-)      
        voc.target@ ( v-)               

        voc.stack> ( v-)                положить в стек словарь
        voc.>stack ( -v)                извлечь верхний словарь
        voc.stack@ ( -v)                верхний элемент без извлечения

        GLOBALS                         vGLOBALS voc.use
        LOCALS                          vLOCALS voc.use

        voc.header ( v-x)               создать новый xt-заголовок в словаре
        voc.header.setname ( px-)       установить имя xt-заголовка
        voc.header.setdata ( ix-)       установить поле данных заголовка
}

type
  PVocItem = ^TVocItem;
  TVocItem = packed record
    Index: Integer; // индекс в таблице команд
    Next: PVocItem;
  end;

  PVoc = ^TVoc;
  TVoc = packed record
    sFIND: Integer;
    sNOTFOUND: Integer;
    Item: PVocItem;
    Time: Integer;
  end;
(*  *)
(*   TVocabulary = class *)
(*   private *)
(*     FCommands: array of PForthCommand;   *)
(*   public *)
(*   end; *)
(*  *)
(*   TVocabularySpace = class *)
(*   private *)
(*     FStack: array of TVocabulary; *)
(*     FCount: Integer; *)
(*     FTarget: array of TVocabulary; *)
(*     FTargets: Integer; *)
(*     FGlobals: TVocabulary; *)
(*     FLocals: TVocabulary; *)
(*   public *)
(*     procedure TargetPush(V: TVocabulary); *)
(*     function TargetPop: TVocabulary; *)
(*     function TargetTop: TVocabulary; *)
(*     procedure Push(V: TVocabulary); *)
(*     function Pop: TVocabulary; *)
(*     function Top: TVocabulary; *)
(*   end; *)
(*  *)
  function VocAdd(V: PVocItem; Index: Integer): PVocItem; overload;
  function VocDel(V: PVocItem; Marker: PVocItem): PVocItem; overload;
  procedure VocAdd(V: PVoc; Index: Integer); overload;
  procedure VocDel(V: PVoc; Marker: PVocItem); overload;

implementation
(*  *)
(* procedure TVocabularySpace.TargetPush(V: TVocabulary); *)
(* begin *)
(*   if FTargets = Length(FTarget) then *)
(*     SetLength(FTarget, Length(FTarget) + 10); *)
(*   Inc(FTargets); *)
(*   FTarget[FTargets - 1] := V; *)
(* end; *)
(*  *)
(* function TVocabularySpace.TargetPop: TVocabulary; *)
(* begin *)
(*   if FTargets > 0 then *)
(*     Dec(FTargets); *)
(*   Result := FTarget[FTargets]; *)
(* end; *)
(*  *)
(* function TVocabularySpace.TargetTop: TVocabulary; *)
(* begin *)
(*   Result := FTarget[FTargets - 1]; *)
(* end; *)
(*  *)
(* procedure TVocabularySpace.Push(V: TVocabulary); *)
(* begin *)
(*   if FCount = Length(FStack) then *)
(*     SetLength(FStack, Length(FStack) + 10); *)
(*   Inc(FTargets); *)
(*   FTarget[FTargets - 1] := V; *)
(* end; *)
(*  *)
(* function TVocabularySpace.Pop: TVocabulary; *)
(* begin *)
(*   if FCount > 0 then *)
(*     Dec(FCount); *)
(*   Result := FStack[FCount]; *)
(* end; *)
(*  *)
(* function TVocabularySpace.Top: TVocabulary; *)
(* begin *)
(*   Result := FStack[FCount - 1]; *)
(* end; *)
(*  *)
function VocAdd(V: PVocItem; Index: Integer): PVocItem;
begin
  New(Result);
  Result^.Index := Index;
  Result^.Next := V;
end;

function VocDel(V: PVocItem; Marker: PVocItem): PVocItem;
begin
  Result := V;
  while (Result <> nil) and (Result <> Marker) do begin
    Result := Result^.Next;
    Dispose(V);
    V := Result;
  end;
end;

procedure VocAdd(V: PVoc; Index: Integer);
begin
  V^.Item := VocAdd(V^.Item, Index);
end;

procedure VocDel(V: PVoc; Marker: PVocItem);
begin
  V^.Item := VocDel(V^.Item, Marker);
end;

end.
