unit DVocabulary;

interface

uses
  DForthMachine;

{
        vocabulary xxx                  ������� ����� �������
        xxx                             �������� � ���� ��������� ����� �������
        voc.use ( v-)                   dup voc.push voc.target !
        ^^^                             voc.pop voc.top voc.target !
        voc.target> ( v-)     
        voc.>target ( v-)      
        voc.target@ ( v-)               

        voc.stack> ( v-)                �������� � ���� �������
        voc.>stack ( -v)                ������� ������� �������
        voc.stack@ ( -v)                ������� ������� ��� ����������

        GLOBALS                         vGLOBALS voc.use
        LOCALS                          vLOCALS voc.use

        voc.header ( v-x)               ������� ����� xt-��������� � �������
        voc.header.setname ( px-)       ���������� ��� xt-���������
        voc.header.setdata ( ix-)       ���������� ���� ������ ���������
}

type
  TVocabulary = class
  private
    FCommands: array of PForthCommand;  
  public
  end;

  TVocabularySpace = class
  private
    FStack: array of TVocabulary;
    FCount: Integer;
    FTarget: array of TVocabulary;
    FTargets: Integer;
    FGlobals: TVocabulary;
    FLocals: TVocabulary;
  public
    procedure TargetPush(V: TVocabulary);
    function TargetPop: TVocabulary;
    function TargetTop: TVocabulary;
    procedure Push(V: TVocabulary);
    function Pop: TVocabulary;
    function Top: TVocabulary;
  end;

implementation

procedure TVocabularySpace.TargetPush(V: TVocabulary);
begin
  if FTargets = Length(FTarget) then
    SetLength(FTarget, Length(FTarget) + 10);
  Inc(FTargets);
  FTarget[FTargets - 1] := V;
end;

function TVocabularySpace.TargetPop: TVocabulary;
begin
  if FTargets > 0 then
    Dec(FTargets);
  Result := FTarget[FTargets];
end;

function TVocabularySpace.TargetTop: TVocabulary;
begin
  Result := FTarget[FTargets - 1];
end;

procedure TVocabularySpace.Push(V: TVocabulary);
begin
  if FCount = Length(FStack) then
    SetLength(FStack, Length(FStack) + 10);
  Inc(FTargets);
  FTarget[FTargets - 1] := V;
end;

function TVocabularySpace.Pop: TVocabulary;
begin
  if FCount > 0 then
    Dec(FCount);
  Result := FStack[FCount];
end;

function TVocabularySpace.Top: TVocabulary;
begin
  Result := FStack[FCount - 1];
end;

end.
