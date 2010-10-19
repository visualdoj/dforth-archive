unit DMath;

interface

const
  EPS = 10e-6;

function Min(A, B: Integer): Integer; overload;
function Max(A, B: Integer): Integer; overload;
function Min(A, B: Single): Single; overload;
function Max(A, B: Single): Single; overload;

type
  TVec2f = packed record
    class operator Add(A, B: TVec2f): TVec2f; inline;
    class operator Subtract(A, B: TVec2f): TVec2f; inline;
    class operator Multiply(A: TVec2f; S: single): TVec2f; overload; inline;
    class operator Multiply(S: single; A: TVec2f): TVec2f; overload; inline;
    class operator Multiply(A, B: TVec2f): TVec2f; overload; inline;
    class operator Divide(A, B: TVec2f): TVec2f; overload; inline;
    class operator Divide(A: TVec2f; S: Single): TVec2f; overload; inline;
    case integer of
      0: (X, Y: Single);
      1: (Arr: array[0..1] of Single);
  end;

  TArrayOfVec2f = array of TVec2f;

  TVec2i = packed record
    class operator Implicit(A: TVec2i): TVec2f; inline;
    class operator Add(A, B: TVec2i): TVec2i; inline;
    class operator Subtract(A, B: TVec2i): TVec2i; inline;
    class operator Multiply(A: TVec2i; I: integer): TVec2i; overload; inline;
    class operator Multiply(A: TVec2i; S: single): TVec2f; overload; inline;
    class operator Multiply(A, B: TVec2i): TVec2i; overload; inline;
    class operator Divide(A, B: TVec2i): TVec2i; overload; inline;
    class operator Divide(A: TVec2i; I: Integer): TVec2i; overload; inline;
    case integer of
      0: (X, Y: integer);
      1: (Arr: array[0..1] of integer);
  end;

  TVec3f = packed record
    class operator Add(A, B: Tvec3f): Tvec3f;
    class operator Subtract(A, B: TVec3f): TVec3f;
    class operator Multiply(Vec: TVec3f; S: Single): TVec3f;
    case integer of
      0: (X, Y, Z: Single);
      1: (Arr: array [0..2] of Single);
  end;

  TVec4f = packed record
    class operator Add(A, B: TVec4f): TVec4f; inline;
    class operator Subtract(A, B: TVec4f): TVec4f; inline;
    class operator Multiply(A: TVec4f; S: Single): TVec4f; overload; inline;
    class operator Multiply(S: Single; A: TVec4f): TVec4f; overload; inline;
    class operator Multiply(A, B: TVec4f): TVec4f; overload; inline;
    case integer of
      0: (X, Y, Z, W: Single);
      1: (Arr: array[0..3] of Single);
  end;

  TRectf = record
    A, B: TVec2f;
  end;

  TRect = TRectf;

  TCirclef = packed record
    Pos: TVec2f;
    Radius: Single;
  end;

  TLine2f = record
    N: TVec2f;
    D: Single;
  end;

  TMatrix4f = array[0..3] of array [0..3] of Single;

TPoly2f = class
 private
  FPoints: array of TVec2f;
  function GetCount: Integer;
  procedure SetCount(Count: Integer);
  function GetPoint(Index: Integer): TVec2f;
  procedure SetPoint(Index: Integer; const Point: TVec2f);
 public
  constructor Create;
  destructor Destroy; override;
  procedure Add(const Point: TVec2f);
  function AsArray: TArrayOfVec2f;
  property Count: Integer read GetCount write SetCount;
  property Points[Index: Integer]: TVec2f read GetPoint write SetPoint; default;
end;

function Vec2i(A, B: Integer): TVec2i;
function Len2i(A: TVec2i): Single;
function Dot2i(A, B: TVec2i): Integer;
function Round2f(V: TVec2f): TVec2i;

function Vec2f(A, B: Single): TVec2f; overload;
function Vec2f(V: TVec2i): TVec2f; overload;
function Len2f(A: TVec2f): Single;
function Dot2f(A, B: TVec2f): Single;
function Norm2f(V: TVec2f): TVec2f;
function Rotate2f(const V: TVec2f; Angle: Single): TVec2f;
function GetNormal2f(const A, B: TVec2f): TVec2f;

function Vec3f(A, B, C: Single): TVec3f;

function Vec4f(A, B, C, D: Single): TVec4f;

function Rect(A, B: TVec2f): TRect;

function Line2f(Vec: TVec2f; S: Single): TLine2f; overload;
function Line2f(A, B: TVec2f): TLine2f; overload;
function Dist2f(Line: TLine2f; P: TVec2f): Single; overload;

function Circle(const Pos: TVec2f; Radius: Single): TCirclef;

implementation

{$Region 'MinMax'}
function Min(A, B: Integer): Integer;
begin
  if A < B then
    Min := A
  else
    Min := B;
end;

function Max(A, B: Integer): Integer;
begin
  if A > B then
    Max := A
  else
    Max := B;
end;

function Min(A, B: Single): Single;
begin
  if A < B then
    Min := A
  else
    Min := B;
end;

function Max(A, B: Single): Single;
begin
  if A > B then
    Max := A
  else
    Max := B;
end;
{$Endregion}
{$Region 'TVec2i'}
function Vec2i(A, B: Integer): TVec2i;
begin
  with Result do
  begin
    X := A;
    Y := B;
  end;
end;

class operator TVec2i.Add(A, B: TVec2i): TVec2i;
begin
  with Result do
  begin
    X := A.X + B.X;
    Y := A.Y + B.Y;
  end;
end;

class operator TVec2i.Subtract(A, B: TVec2i): TVec2i;
begin
  with Result do
  begin
    X := A.X - B.X;
    Y := A.Y - B.Y;
  end;
end;

class operator TVec2i.Multiply(A: TVec2i; I: integer): TVec2i;
begin
  with Result do
  begin
    X := I * A.X;
    Y := I * A.Y;
  end;
end;

class operator TVec2i.Multiply(A: TVec2i; S: single): TVec2f;
begin
  with Result do
  begin
    X := S * A.X;
    Y := S * A.Y;
  end;
end;

class operator TVec2i.Multiply(A, B: TVec2i): TVec2i;
begin
  with Result do
  begin
    X := A.X * B.X;
    Y := A.Y * B.Y;
  end;
end;

class operator TVec2i.Divide(A: TVec2i; B: TVec2i): TVec2i;
begin
  with Result do
  begin
    X := A.X div B.X;
    Y := A.Y div B.Y;
  end;
end;

class operator TVec2i.Divide(A: TVec2i; I: Integer): TVec2i;
begin
  with Result do
  begin
    X := A.X div I;
    Y := A.Y div I;
  end;
end;

function Round2f(V: TVec2f): TVec2i;
begin
  with Result do
  begin
    X := Round(V.X);
    Y := Round(V.Y);
  end;
end;

function Len2i(A: TVec2i): Single;
begin
  Result := Sqrt(Sqr(A.X) + Sqr(A.Y));
end;

function Dot2i(A, B: TVec2i): Integer;
begin
  Result := A.X * B.X + A.Y * B.Y;
end;
{$Endregion}
{$Region 'TVec2f'}
function Vec2f(A, B: Single): TVec2f;
begin
  with Result do
  begin
    X := A;
    Y := B;
  end;
end;

function Vec2f(V: TVec2i): TVec2f;
begin
  with Result do
    Vec2f(X, Y);
end;

class operator TVec2i.Implicit(A: TVec2i): TVec2f;
begin
  with Result do
  begin
    X := A.X;
    Y := A.Y;
  end;
end;

class operator TVec2f.Add(A, B: TVec2f): TVec2f;
begin
  with Result do
  begin
    X := A.X + B.X;
    Y := A.Y + B.Y;
  end;
end;

class operator TVEc2f.Subtract(A, B: TVec2f): TVec2f;
begin
  with Result do
  begin
    X := A.X - B.X;
    Y := A.Y - B.Y;
  end;
end;

class operator TVec2f.Multiply(A: TVec2f; S: single): TVec2f;
begin
  with Result do
  begin
    X := S * A.X;
    Y := S * A.Y;
  end;
end;

class operator TVec2f.Multiply(S: single; A: TVec2f): TVec2f;
begin
  with Result do
  begin
    X := S * A.X;
    Y := S * A.Y;
  end;
end;

class operator TVec2f.Multiply(A, B: TVec2f): TVec2f;
begin
  with Result do
  begin
    X := A.X * B.X;
    Y := A.Y * B.Y;
  end;
end;

class operator TVec2f.Divide(A: TVec2f; B: TVec2f): TVec2f;
begin
  with Result do
  begin
    X := A.X / B.X;
    Y := A.Y / B.Y;
  end;
end;

class operator TVec2f.Divide(A: TVec2f; S: Single): TVec2f;
begin
  with Result do
  begin
    X := A.X / S;
    Y := A.Y / S;
  end;
end;

function Len2f(A: TVec2f): Single;
begin
  Result := Sqrt(Sqr(A.X) + Sqr(A.Y));
end;

function Dot2f(A, B: TVec2f): Single;
begin
  Result := A.X * B.X  +  A.Y * B.Y;
end;

function Norm2f(V: TVec2f): TVec2f;
begin
  Result := V  / Len2f(V);
end;

function Rotate2f(const V: TVec2f; Angle: Single): TVec2f;
  var
    C, S: Single;
begin
  C := Cos(Angle);
  S := Sin(Angle);
  Rotate2f.X := C * V.X  -  S * V.Y;
  Rotate2f.Y := C * V.Y  +  S * V.X;
end;

function GetNormal2f(const A, B: TVec2f): TVec2f;
begin
  Result := B - A;
  Result := Vec2f(- Result.Y, Result.X);
end;
{$Endregion}
{$Region 'TVec3f'}

function Vec3f(A, B, C: Single): TVec3f;
begin
  with Result do
  begin
    X := A;
    Y := B;
    Z := C;
  end;
end;

class operator TVec3f.Add(A: TVec3f; B: TVec3f): TVec3f;
begin
  with Result do
  begin
    X := A.X + B.X;
    Y := A.Y + B.Y;
    Z := A.Z + B.Z;
  end;
end;

class operator TVec3f.Subtract(A: TVec3f; B: TVec3f): TVec3f;
begin
  with Result do
  begin
    X := A.X - B.X;
    Y := A.Y - B.Y;
    Z := A.Z - B.Z;
  end;
end;

class operator TVec3f.Multiply(Vec: TVec3f; S: Single): TVec3f;
begin
  with Result do
  begin
    X := Vec.X * S;
    Y := Vec.Y * S;
    Z := Vec.Z * S;
  end;
end;

{$Endregion}
{$Region 'TVec4f'}

function Vec4f(A, B, C, D: Single): TVec4f;
begin
  with Result do
  begin
    X := A;
    Y := B;
    Z := C;
    W := D;
  end;
end;

class operator TVec4f.Add(A, B: TVec4f): TVec4f;
begin
  with Result do
  begin
    X := A.X + B.X;
    Y := A.Y + B.Y;
    Z := A.Z + B.Z;
    W := A.W + B.W;
  end;
end;

class operator TVec4f.Subtract(A, B: TVec4f): TVec4f;
begin
  with Result do
  begin
    X := A.X - B.X;
    Y := A.Y - B.Y;
    Z := A.Z - B.Z;
    W := A.W - B.W;
  end;
end;

class operator TVec4f.Multiply(A: TVec4f; S: Single): TVec4f;
begin
  with Result do
  begin
    X := A.X * S;
    Y := A.Y * S;
    Z := A.Z * S;
    W := A.W * S;
  end;
end;

class operator TVec4f.Multiply(S: Single; A: TVec4f): TVec4f;
begin
  with Result do
  begin
    X := A.X * S;
    Y := A.Y * S;
    Z := A.Z * S;
    W := A.W * S;
  end;
end;

class operator TVec4f.Multiply(A, B: TVec4f): TVec4f;
begin
  with Result do
  begin
    X := A.X * B.X;
    Y := A.Y * B.Y;
    Z := A.Z * B.Z;
    W := A.W * B.W;
  end;
end;

{$Endregion}
{$Region 'TRect'}

function Rect(A, B: TVec2f): TRect;
begin
  Rect.A := A;
  Rect.B := B;
end;

{$Endregion}
{$Region 'TLine2f'}
function Line2f(Vec: TVec2f; S: Single): TLine2f;
begin
  with Result do
  begin
    N := Vec;
    D := S;
  end;
end;

function Line2f(A, B: TVec2f): TLine2f;
begin
  with Result do
  begin
    N := (B - A)/Len2f(B - A);
    N := Vec2f(- Result.N.Y, Result.N.X);
    D := - Dot2f(A, Result.N);
  end;
end;

function Dist2f(Line: TLine2f; P: TVec2f): Single; overload;
begin
  Result := Dot2f(Line.N, P) + Line.D;
end;
{$Endregion}
{$REGION 'TPoly2f'}
function TPoly2f.GetCount: Integer;
begin
  GetCount := Length(FPoints);
end;

procedure TPoly2f.SetCount(Count: Integer);
begin
  SetLength(FPoints, Count);
end;

function TPoly2f.GetPoint(Index: Integer): TVec2f;
begin
  if Count > 0 then
    GetPoint := FPoints[Index mod Count]
  else
    GetPoint := Vec2f(0, 0);
end;

procedure TPoly2f.SetPoint(Index: Integer; const Point: TVec2f);
begin
  if Count > 0 then
    FPoints[Index mod Count] := Point;
end;

constructor TPoly2f.Create;
begin
  SetLength(FPoints, 0);
end;

destructor TPoly2f.Destroy;
begin
end;

procedure TPoly2f.Add(const Point: TVec2f);
begin
  Count := Count + 1;
  FPoints[Count - 1] := Point;
end;

function TPoly2f.AsArray: TArrayOfVec2f;
  var
    I: Integer;
begin
  SetLength(Result, Count);
  for I := 0 to Count - 1 do
    Result[I] := FPoints[I];
end;
{$ENDREGION}

function Circle(const Pos: TVec2f; Radius: Single): TCirclef;
begin
  Circle.Pos := Pos;
  Circle.Radius := Radius;
end;


end.
