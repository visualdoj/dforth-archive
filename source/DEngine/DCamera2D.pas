unit DCamera2D;

interface

uses
  DCore,
  DMath,
  DIntersection,
  DUtils;

type
TCamera2D = class(TStreamable)
private
  FPos: TVec2f;
  FSize: TVec2f;
  FCenter: TRect;
  FObj: TVec2f;
protected
  procedure Stream; override;
public
  constructor Create;
  destructor Destroy; override;
  procedure Bind;
  procedure Focus;
  procedure Unfocus;
  procedure Update(Obj: TVec2f);
  property Center: TRect read FCenter write FCenter;
  property Pos: TVec2f read FPos;
  property Size: TVec2f read FSize write FSize;
end;

implementation

procedure TCamera2D.Stream;//{{{
begin
  inherited;
  Stream(@FPos, SizeOf(FPos));
  Stream(@FSize, SizeOf(FSize));
  Stream(@FCenter, SizeOf(FCenter));
  Stream(@FObj, SizeOf(FObj));
end;
//}}}
constructor TCamera2D.Create;//{{{
begin
  FPos := Vec2f(0, 0);
  FSize := Vec2f(GWidth, GHeight);
  FObj := FPos + FSize/2;
  FCenter := Rect(1/4*FSize, 3/4*FSize)
end;

//}}}
destructor TCamera2D.Destroy;//{{{
begin
  inherited;
end;

//}}}
procedure TCamera2D.Bind;//{{{
begin
  Core.Graph.BeginRender2D(Round(FSize.X), Round(FSize.Y));
end;

//}}}
procedure TCamera2D.Focus;//{{{
begin
  Core.Graph.PushMatrix;
  Core.Graph.Translate(Round2f((-1)*FPos));
end;

//}}}
procedure TCamera2D.Unfocus;//{{{
begin
  Core.Graph.PopMatrix;
end;

//}}}
procedure TCamera2D.Update(Obj: TVec2f);//{{{
  var
    Delta: TVec2f;
begin
  FObj := Obj;
  if not Intersect(Rect(Vec2f(0, 0), FSize), FObj - FPos, Delta) then
    FPos := FPos + Delta*1.1;
  if not Intersect(FCenter, FObj - FPos, Delta) then
    FPos := FPos + Delta/2;
  // дешевый хак - деление пополам реализует ускорение и делает камеру плавной
end;

//}}}

initialization
  Factory.Regist(TCamera2D);
end.
