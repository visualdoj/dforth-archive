{$MACRO ON}
{$MODE OBJFPC}
unit DMath;

interface

{$DEFINE FASTMATH}
{$DEFINE OPMATH}
{$DEFINE MathDir:={$IFDEF FASTMATH}inline;{$ENDIF}}

const
  EPS = 10e-6;

function Min(A, B: Integer): Integer;
function Max(A, B: Integer): Integer;
function Min(A, B: Single): Single;
function Max(A, B: Single): Single;

type
TVec2i = packed record
  case integer of
    0: (X, Y: integer);
    1: (Arr: array[0..1] of integer);
end;
TArrayOfVec2i = array of TVec2i;

TVec2f = packed record
  case integer of
    0: (X, Y: Single);
    1: (Arr: array[0..1] of Single);
end;
TArrayOfVec2f = array of TVec2f;

TVec3f = packed record
  case integer of
    0: (X, Y, Z: Single);
    1: (Arr: array[0..2] of Single);
end;
TArrayOfVec3f = array of TVec3f;

TVec4f = packed record
  case integer of
    0: (X, Y, Z, W: Single);
    1: (Arr: array[0..3] of Single);
end;
TArrayOfVec4f = array of TVec4f;

TRectf = record
  case Integer of
    0: (A, B: TVec2f);
    1: (Left, Top, Right, Bottom: Single);
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

TRay2f = record
  Pos: TVec2f;
  Dir: TVec2f;
end; 

TMatrix4f = array[0..3] of array[0..3] of Single;

TQuat = packed record
  case integer of
    0: (X, Y, Z, W: Single);
    1: (Arr: array[0..3] of Single);
    2: (V: TVec3f; A: Single);
    3: (Vec4f: TVec4f);
end;

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

function Vec2i(X, Y: Integer): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Round2f(V: TVec2f): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Add2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Sub2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul2i(A: TVec2i; I: integer): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul2i(A: TVec2i; S: single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Len2i(A: TVec2i): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Dot2i(A, B: TVec2i): Integer; {$IFDEF FASTMATH}inline;{$ENDIF}

function Vec2f(X, Y: Single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Vec2f(V: TVec2i): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Add2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Sub2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul2f(A: TVec2f; S: single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Len2f(A: TVec2f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Dot2f(A, B: TVec2f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Norm2f(V: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Rotate2f(const V: TVec2f; Angle: Single): TVec2f; 
function GetNormal2f(const A, B: TVec2f): TVec2f;

function Vec3f(X, Y, Z: Single): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Add3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Sub3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul3f(A: TVec3f; S: single): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Len3f(A: TVec3f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Dot3f(A, B: TVec3f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Cross3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Norm3f(V: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}

function Vec4f(X, Y, Z, W: Single): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Add4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Sub4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
function Mul4f(A: TVec4f; S: Single): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
function QLen4f(const A: TVec4f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Len4f(const A: TVec4f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
function Norm4f(const A: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}

function MatrixApply(const M: TMatrix4f; const V: TVec2f): TVec2f; overload;
function MatrixApply(const M: TMatrix4f; const V: TVec3f): TVec3f; overload;
function MatrixApply(const M: TMatrix4f; const V: TVec4f): TVec4f; overload;
function MatrixIdentity: TMatrix4f;
function MatrixRotation(Angle: Single; const V: TVec3f): TMatrix4f;
function MatrixTranslation(const V: TVec3f): TMatrix4f;
function MatrixScale(const S: TVec3f): TMatrix4f;
function MatrixDet(const M: TMatrix4f): Single;
function MatrixInverse(const M: TMatrix4f): TMatrix4f;
function MatrixMul(const M: TMatrix4f; V: Single): TMatrix4f;
function MatrixMul(const A, B: TMatrix4f): TMatrix4f;
function MatrixQuat(const Q: TQuat): TMatrix4f;

function Quat(X, Y, Z, W: Single): TQuat;
function QuatEuler(Yaw, Pitch, Roll: Single): TQuat;
function QuatNorm(const Q: TQuat): TQuat;
function QuatRotation(Angle: Single; const V: TVec3f): TQuat;
function QuatMul(const Q1, Q2: TQuat): TQuat;
function QuatLerp(const A, B: TQuat; T: Single): TQuat;
function QuatSlerp(const A, B: TQuat; T: Single): TQuat;
function QuatInvert(const Q: TQuat): TQuat;
function QuatApply(const Q: TQuat; const V: TVec3f): TVec3f;
function QuatMatrix(const M: TMatrix4f): TQuat;

function Rect(A, B: TVec2f): TRect; overload;
function Rect(Left, Top, Right, Bottom: Single): TRect; overload;
function Bounds(X, Y, Width, Height: Single): TRect;

function Circle(const Pos: TVec2f; Radius: Single): TCirclef;

function Line2f(N: TVec2f; D: Single): TLine2f; overload;
function Line2f(A, B: TVec2f): TLine2f; overload;
function Dist2f(Line: TLine2f; P: TVec2f): Single; overload;

{$IFDEF OPMATH}
operator = (A, B: TVec2i) _Result: Boolean; inline;
operator := (A: TVec2i) _Result: TVec2f; inline;
operator + (A, B: TVec2i) _Result: TVec2i; inline;
operator + (A, B: TVec2f) _Result: TVec2f; inline;
operator + (A, B: TVec3f) _Result: TVec3f; inline;
operator + (A, B: TVec4f) _Result: TVec4f; inline;
operator - (A, B: TVec2i) _Result: TVec2i; inline;
operator - (A, B: TVec2f) _Result: TVec2f; inline;
operator - (A, B: TVec3f) _Result: TVec3f; inline;
operator - (A, B: TVec4f) _Result: TVec4f; inline;
operator - (A: TVec2i) _Result: TVec2i; inline;
operator - (A: TVec2f) _Result: TVec2f; inline;
operator - (A: TVec3f) _Result: TVec3f; inline;
operator - (A: TVec4f) _Result: TVec4f; inline;
operator * (A, B: TVec2i) _Result: TVec2i; inline;
operator * (A, B: TVec2f) _Result: TVec2f; inline;
operator * (A, B: TVec3f) _Result: TVec3f; inline;
operator * (A, B: TVec4f) _Result: TVec4f; inline;
operator * (I: integer; A: TVec2i) _Result: TVec2i; inline;
operator * (A: TVec2i; I: Integer) _Result: TVec2i; inline;
operator * (S: Single; A: TVec2f) _Result: TVec2f; inline;
operator * (A: TVec2f; S: Single) _Result: TVec2f; inline;
operator * (A: TVec4f; S: Single) _Result: TVec4f; inline;
operator * (S: Single; A: TVec4f) _Result: TVec4f; inline;
//operator div (A: TVec2i; I: Integer) _Result: TVec2i; inline;
operator / (A: TVec2f; S: Single) _Result: TVec2f; inline;
operator := (V: Single) _Result: TMatrix4f; inline;
operator * (A, B: TMatrix4f) _Result: TMatrix4f; inline;
operator * (M: TMatrix4f; V: Single) _Result: TMatrix4f; inline;
operator * (V: Single; M: TMatrix4f) _Result: TMatrix4f; inline;
operator / (M: TMatrix4f; V: Single) _Result: TMatrix4f; inline;
operator * (M: TMatrix4f; V: TVec2f) _Result: TVec2f; inline;
operator * (M: TMatrix4f; V: TVec3f) _Result: TVec3f; inline;
operator * (M: TMatrix4f; V: TVec4f) _Result: TVec4f; inline;
operator * (Q1: TQuat; Q2: TQuat) _Result: TQuat; inline;
operator * (Q: TQuat; V: TVec3f) _Result: TVec3f; inline;
operator * (Q: TQuat; M: TMatrix4f) _Result: TMatrix4f; inline;
operator * (M: TMatrix4f; Q: TQuat) _Result: TMatrix4f; inline;
operator - (Q: TQuat) _Result: TQuat; inline;
{$ENDIF}

const
  Zero2f: TVec2f = (x: 0; y: 0);
  Zero3f: TVec3f = (x: 0; y: 0; z: 0);

implementation

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

{$IFNDEF FLAG_FPC}{$REGION 'TVec2i'}{$ENDIF}
// TVec2i//{{{
function Vec2i(X, Y: Integer): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Vec2i.X := X;
  Vec2i.Y := Y;
end;

function Round2f(V: TVec2f): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Round2f.X := Round(V.X);
  Round2f.Y := Round(V.Y);
end;

function Add2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Add2i.X := A.X + B.X;
  Add2i.Y := A.Y + B.Y;
end;

function Sub2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Sub2i.X := A.X - B.X;
  Sub2i.Y := A.Y - B.Y;
end;

function Mul2i(A, B: TVec2i): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul2i.X := A.X * B.X;
  Mul2i.Y := A.Y * B.Y;
end;

function Mul2i(A: TVec2i; I: integer): TVec2i; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul2i.X := I * A.X;
  Mul2i.Y := I * A.Y;
end;

function Mul2i(A: TVec2i; S: single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul2i.X := S * A.X;
  Mul2i.Y := S * A.Y;
end;

function Len2i(A: TVec2i): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Len2i := Sqrt(Sqr(A.X) + Sqr(A.Y));
end;
//}}}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TVec2f'}{$ENDIF}
function Vec2f(X, Y: Single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Vec2f.X := X;
  Vec2f.Y := Y;
end;

function Vec2f(V: TVec2i): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Vec2f := Vec2f(V.X, V.Y);
end;

function Add2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Add2f.X := A.X + B.X;
  Add2f.Y := A.Y + B.Y;
end;

function Sub2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Sub2f.X := A.X - B.X;
  Sub2f.Y := A.Y - B.Y;
end;

function Mul2f(A, B: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul2f.X := A.X * B.X;
  Mul2f.Y := A.Y * B.Y;
end;

function Mul2f(A: TVec2f; S: single): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul2f.X := S * A.X;
  Mul2f.Y := S * A.Y;
end;

function Len2f(A: TVec2f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Len2f := Sqrt(Sqr(A.X) + Sqr(A.Y));
end;

function Dot2f(A, B: TVec2f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Dot2f := A.X * B.X  +  A.Y * B.Y;
end;

function Norm2f(V: TVec2f): TVec2f; {$IFDEF FASTMATH}inline;{$ENDIF}
  var
    L: Single;
begin
  L := Len2f(V);
  if Abs(L) > EPS then
    Norm2f := V / Len2f(V)
  else
    Norm2f := Vec2f(0, 0);
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

function Dot2i(A, B: TVec2i): Integer; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Dot2i := A.X*B.X + A.Y*B.Y;
end;
//}}}{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TVec3f'}{$ENDIF}
function Vec3f(X, Y, Z: Single): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Vec3f.X := X;
  Vec3f.Y := Y;
  Vec3f.Z := Z;
end;

function Add3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Add3f.X := A.X + B.X;
  Add3f.Y := A.Y + B.Y;
  Add3f.Z := A.Z + B.Z;
end;

function Sub3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Sub3f.X := A.X - B.X;
  Sub3f.Y := A.Y - B.Y;
  Sub3f.Z := A.Z - B.Z;
end;

function Mul3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul3f.X := A.X * B.X;
  Mul3f.Y := A.Y * B.Y;
  Mul3f.Z := A.Z * B.Z;
end;

function Mul3f(A: TVec3f; S: single): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul3f.X := A.X * S;
  Mul3f.Y := A.Y * S;
  Mul3f.Z := A.Z * S;
end;

function Len3f(A: TVec3f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Len3f := Sqrt(Sqr(A.X) + Sqr(A.Y) + Sqr(A.Z));
end;

function Dot3f(A, B: TVec3f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Dot3f := A.X*B.X + A.Y*B.Y * A.Z*B.Z;
end;

function Norm3f(V: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
var
  L: Single;
begin
  L := Len3f(V);
  if Abs(L) < 10e-6 then
    Result := Vec3f(0, 0, 0)
  else
    Norm3f := Mul3f(V, 1/L);
end;

function Cross3f(A, B: TVec3f): TVec3f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Cross3f.X := A.Y*B.Z - A.Z*B.Y;
  Cross3f.Y := A.Z*B.X - A.X*B.Z;
  Cross3f.Z := A.X*B.Y - A.Y*B.Z;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TVec4f'}{$ENDIF}
//{{{ TVec4f
function Vec4f(X, Y, Z, W: Single): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Vec4f.X := X;
  Vec4f.Y := Y;
  Vec4f.Z := Z;
  Vec4f.W := W;
end;

function Add4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Add4f.X := A.X + B.X;
  Add4f.Y := A.Y + B.Y;
  Add4f.Z := A.Z + B.Z;
  Add4f.W := A.W + B.W;
end;

function Sub4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Sub4f.X := A.X - B.X;
  Sub4f.Y := A.Y - B.Y;
  Sub4f.Z := A.Z - B.Z;
  Sub4f.W := A.W - B.W;
end;

function Mul4f(A, B: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul4f.X := A.X * B.X;
  Mul4f.Y := A.Y * B.Y;
  Mul4f.Z := A.Z * B.Z;
  Mul4f.W := A.W * B.W;
end;

function Mul4f(A: TVec4f; S: Single): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Mul4f.X := A.X * S;
  Mul4f.Y := A.Y * S;
  Mul4f.Z := A.Z * S;
  Mul4f.W := A.W * S;
end;

function QLen4f(const A: TVec4f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  QLen4f := Sqr(A.X) + Sqr(A.X) + Sqr(A.Z) + Sqr(A.W);
end;

function Len4f(const A: TVec4f): Single; {$IFDEF FASTMATH}inline;{$ENDIF}
begin
  Len4f := Sqrt(QLen4f(A));
end;

function Norm4f(const A: TVec4f): TVec4f; {$IFDEF FASTMATH}inline;{$ENDIF}
var
  L: Single;
begin
  L := Len4f(A);
  if Abs(L) < 10e-6 then
    Result := Vec4f(0, 0, 0, 0)
  else
    Norm4f := Mul4f(A, 1/L);
end;
//}}}{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TMatrix4f'}{$ENDIF}
function MatrixApply(const M: TMatrix4f; const V: TVec2f): TVec2f; overload;
begin
  MatrixApply.X := M[0][0]*V.X + M[1][0]*V.Y + M[3][0];
  MatrixApply.Y := M[0][1]*V.X + M[1][1]*V.Y + M[3][1];
end;

function MatrixApply(const M: TMatrix4f; const V: TVec3f): TVec3f; overload;
begin
  MatrixApply.X := M[0][0]*V.X + M[1][0]*V.Y + M[2][0]*V.Z + M[3][0];
  MatrixApply.Y := M[0][1]*V.X + M[1][1]*V.Y + M[2][1]*V.Z + M[3][1];
  MatrixApply.Z := M[0][2]*V.X + M[1][2]*V.Y + M[2][2]*V.Z + M[3][2];
end;

function MatrixApply(const M: TMatrix4f; const V: TVec4f): TVec4f; overload;
begin
  MatrixApply.X := M[0][0]*V.X + M[1][0]*V.Y + M[2][0]*V.Z + M[3][0]*V.W;
  MatrixApply.Y := M[0][1]*V.X + M[1][1]*V.Y + M[2][1]*V.Z + M[3][1]*V.W;
  MatrixApply.Z := M[0][2]*V.X + M[1][2]*V.Y + M[2][2]*V.Z + M[3][2]*V.W;
  MatrixApply.W := M[0][3]*V.X + M[1][3]*V.Y + M[2][3]*V.Z + M[3][3]*V.W;
end;

function MatrixIdentity: TMatrix4f;
  var
    I, J: Integer;
begin
  for I := 0 to 3 do
    for J := 0 to 3 do
      MatrixIdentity[I][J] := Ord(I = J);
end;

function MatrixRotation(Angle: Single; const V: TVec3f): TMatrix4f;
  Var
    S, C, Inv_C : single;
begin
  S := sin(Angle);
  C := cos(Angle);
  Inv_C := 1 - C;

  MatrixRotation[0][ 0] := (Inv_C * V.X * V.X) + C;
  MatrixRotation[0][ 1] := (Inv_C * V.X * V.Y) - (V.Z * S);
  MatrixRotation[0][ 2] := (Inv_C * V.Z * V.X) + (V.Y * S);

  MatrixRotation[1][ 0] := (Inv_C * V.X * V.Y) + (V.Z * S);
  MatrixRotation[1][ 1] := (Inv_C * V.Y * V.Y) + C;
  MatrixRotation[1][ 2] := (Inv_C * V.Y * V.Z) - (v.X * S);

  MatrixRotation[2][ 0] := (Inv_C * V.Z * V.X) - (v.Y * S);
  MatrixRotation[2][ 1] := (Inv_C * V.Y * V.Z) + (v.X * S);
  MatrixRotation[2][ 2] := (Inv_C * V.Z * V.Z) + C;

  MatrixRotation[3][ 0] := 0;
  MatrixRotation[3][ 1] := 0;
  MatrixRotation[3][ 2] := 0;
  MatrixRotation[0][ 3] := 0;
  MatrixRotation[1][ 3] := 0;
  MatrixRotation[2][ 3] := 0;
  MatrixRotation[3][ 3] := 1;
end;

function MatrixTranslation(const V: TVec3f): TMatrix4f;
begin
  MatrixTranslation := MatrixIdentity;
  MatrixTranslation[3][0] := V.X;
  MatrixTranslation[3][1] := V.Y;
  MatrixTranslation[3][2] := V.Z;
end;

function MatrixScale(const S: TVec3f): TMatrix4f;
begin
  MatrixScale := MatrixIdentity;
  MatrixScale[0][0] := S.X;
  MatrixScale[1][1] := S.Y;
  MatrixScale[2][2] := S.Z;
end;

function MatrixDet(const M: TMatrix4f): Single;
  var
    I, J, L, K, S: Integer;
begin
  S := 1;
  MatrixDet := 0;
  for I := 0 to 3 do
    for J := 0 to 3 do
      if J <> I then
        for K := 0 to 3 do
          if (K <> I)and(K <> J) then
            for L := 0 to 3 do
              if (L <> I) and (L <> J) and (L <> K) then begin
                MatrixDet := MatrixDet + S*M[0][I]*M[1][J]*M[2][K]*M[3][L];
                S := -S;
              end;
end;

function MatrixInverse(const M: TMatrix4f): TMatrix4f;
  var
    _Det: Single;
    Src: array[0..15] of Single absolute M;
    Dest: array[0..15] of Single absolute MatrixInverse;
begin
  _Det := 1 / MatrixDet(M);
  Dest[ 0] :=  (Src[5] * Src[10] - Src[9] * Src[6]) * _Det;
  Dest[ 1] := -(Src[1] * Src[10] - Src[9] * Src[2]) * _Det;
  Dest[ 2] :=  (Src[1] * Src[ 6] - Src[5] * Src[2]) * _Det;
  Dest[ 3] := 0;
  Dest[ 4] := -(Src[4] * Src[10] - Src[8] * Src[6]) * _Det;
  Dest[ 5] :=  (Src[0] * Src[10] - Src[8] * Src[2]) * _Det;
  Dest[ 6] := -(Src[0] * Src[ 6] - Src[4] * Src[2]) * _Det;
  Dest[ 7] := 0;
  Dest[ 8] :=  (Src[4] * Src[9] - Src[8] * Src[5]) * _Det;
  Dest[ 9] := -(Src[0] * Src[9] - Src[8] * Src[1]) * _Det;
  Dest[10] :=  (Src[0] * Src[5] - Src[4] * Src[1]) * _Det;
  Dest[11] := 0;
  Dest[12] := -(Src[12] * Dest[0] + Src[13] * Dest[4] + Src[14] * Dest[ 8]);
  Dest[13] := -(Src[12] * Dest[1] + Src[13] * Dest[5] + Src[14] * Dest[ 9]);
  Dest[14] := -(Src[12] * Dest[2] + Src[13] * Dest[6] + Src[14] * Dest[10]);
  Dest[15] := 1;
end;

function MatrixMul(const M: TMatrix4f; V: Single): TMatrix4f;
  var
    I, J: Integer;
begin
  for I := 0 to 3 do
    for J := 0 to 3 do
      MatrixMul[I][J] := M[I][J] * V;
end;

function MatrixMul(const A, B: TMatrix4f): TMatrix4f;
  var
    I, J, K: Integer;
begin
  for I := 0 to 3 do
    for J := 0 to 3 do begin
      MatrixMul[I][J] := 0;
      for K := 0 to 3 do
        MatrixMul[I][J] := MatrixMul[I][J]  +  A[K][J] * B[I][K];
    end;
end;

function MatrixQuat(const Q: TQuat): TMatrix4f;
var
  wx, wy, wz, xx, yy, yz, xy, xz, zz, x2, y2, z2: single;
  m: array[0..15] of Single absolute MatrixQuat;
begin
  with Q do begin
    x2 := x + x;   y2 := y + y;   z2 := z + z;
    xx := x * x2;  xy := x * y2;  xz := x * z2;
    yy := y * y2;  yz := y * z2;  zz := z * z2;
    wx := w * x2;  wy := w * y2;  wz := w * z2;
  end;

  m[0] := 1 - (yy + zz);  m[4] := xy + wz;        m[ 8] := xz - wy;
  m[1] := xy - wz;        m[5] := 1 - (xx + zz);  m[ 9] := yz + wx;
  m[2] := xz + wy;        m[6] := yz - wx;        m[10] := 1 - (xx + yy);

  m[ 3] := 0;
  m[ 7] := 0;
  m[11] := 0;
  m[12] := 0;
  m[13] := 0;
  m[14] := 0;
  m[15] := 1;
end;

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TQuat'}{$ENDIF}
function Quat(X, Y, Z, W: Single): TQuat;
begin
  Quat.X := X;
  Quat.Y := Y;
  Quat.Z := Z;
  Quat.W := W;
end;

function QuatEuler(Yaw, Pitch, Roll: Single): TQuat;
  var
    QRoll, QPitch, QYaw: TQuat;
begin
  QRoll := Quat(Sin(Roll/2), 0, 0, Cos(Roll/2));
  QPitch := Quat(0, Sin(Pitch/2), 0, Cos(Pitch/2));
  QYaw := Quat(0, 0, Sin(Yaw/2), Cos(Yaw/2));
  QuatEuler := QuatMul(QYaw, QuatMul(QPitch, QRoll));
end;

function QuatNorm(const Q: TQuat): TQuat;
begin
  QuatNorm.Vec4f := Norm4f(Q.Vec4f);
end;

function QuatRotation(Angle: Single; const V: TVec3f): TQuat;
  var
    U: TVec3f;
begin
  U := Sin(Angle/2) * V;
  QuatRotation.X := U.X;
  QuatRotation.Y := U.Y;
  QuatRotation.Z := U.Z;
  QuatRotation.W := Cos(Angle/2);
  //QuatRotation := QuatNorm(QuatRotation);
end;

function QuatMul(const Q1, Q2: TQuat): TQuat;
  var
    V, V1, V2: TVec3f;
begin
  V1 := Vec3f(Q1.X, Q1.Y, Q1.Z);
  V2 := Vec3f(Q2.X, Q2.Y, Q2.Z);
  V := Add3f(Cross3f(V1, V2), Add3f(Mul3f(V2, Q1.W), Mul3f(V1, Q2.W))); 
  QuatMul.X := V.X;
  QuatMul.Y := V.Y;
  QuatMul.Z := V.Z;
  QuatMul.W := Q1.W * Q2.W - Dot3f(V1, V2);
end;

function QuatLerp(const A, B: TQuat; T: Single): TQuat;
begin
  QuatLerp.X := (1 - T) * A.X  +  T * B.X;
  QuatLerp.Y := (1 - T) * A.Y  +  T * B.Y;
  QuatLerp.Z := (1 - T) * A.Z  +  T * B.Z;
  QuatLerp.W := (1 - T) * A.W  +  T * B.W;
end;

function QuatSlerp(const A, B: TQuat; T: Single): TQuat;
{ TODO
  Var
    CosOm, Omega, SinOm, Scale1, Scale2: Single;
begin
  CosOm := Q1.X * Q2.X + Q1.Y * Q2.Y + Q1.Z * Q2.Z + Q1.W * Q2.W;
    If CosOm < 0 then begin
      CosOm := - CosOm;
      Q2 := Mul4D(Q2, -1);
    end;
    If CosOm < 0.9999 then begin
      Omega := ArcCos(CosOm);
      SinOm := Sin(Omega);
      Scale1 := Sin((1 - T) * Omega) / SinOm;
      Scale2 := Sin(T * Omega) / SinOm;
      _Result := Add4D(Mul4D(Q1, Scale1), Mul4D(Q2, Scale2));
    end else
      _Result := Lerp4D(Q1, Q2, T);}
begin
  QuatSlerp := Quat(0, 0, 0, 1);
end;

function QuatInvert(const Q: TQuat): TQuat;
begin
  QuatInvert := Q;//QuatNorm(Q);
  QuatInvert.W := - QuatInvert.W;
end;

function QuatApply(const Q: TQuat; const V: TVec3f): TVec3f;
  var
    Temp: TQuat;
begin
  Temp := Quat(V.X, V.Y, V.Z, 0);
  Temp := QuatMul(Temp, QuatInvert(Q));
  Temp := QuatMul(Q, Temp);
  QuatApply := Vec3f(Temp.X, Temp.Y, Temp.Z);
end;

function QuatMatrix(const M: TMatrix4f): TQuat;
const
  Nxt: array[0..2] of Integer = (1, 2, 0);
var
  Tr, S: Single;
  Q: array[0..3] of Single;
  I, J, K: Integer;
begin
  Tr := M[0][0] + M[1][1] + M[2][2];
  if Tr > 0.0 then begin
    S := Sqrt(Tr + 1.0);
    QuatMatrix.W := S / 2.0;
    S := 0.5 / S;
    QuatMatrix.X := (M[1][2] - M[2][1]) * S;
    QuatMatrix.Y := (M[2][0] - M[0][2]) * S;
    QuatMatrix.Z := (M[0][1] - M[1][0]) * S;
  end else begin
    i := 0;
    if m[1][1] > m[0][0] then
      i := 1;
    if m[2][2] > m[i][i] then
      i := 2;
    j := nxt[i];
    k := nxt[j];

    s := sqrt ((m[i][i] - (m[j][j] + m[k][k])) + 1.0);

    q[i] := s * 0.5;

    if (s <> 0.0) then
      s := 0.5 / s;

    q[3] := (m[j][k] - m[k][j]) * s;
    q[j] := (m[i][j] + m[j][i]) * s;
    q[k] := (m[i][k] + m[k][i]) * s;

    QuatMatrix.x := q[0];
    QuatMatrix.y := q[1];
    QuatMatrix.z := q[2];
    QuatMatrix.w := q[3];
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
//{{{ TRect
function Rect(A, B: TVec2f): TRect;
begin
  Rect.A := A;
  Rect.B := B;
end;
//}}}

function Rect(Left, Top, Right, Bottom: Single): TRect;
begin
  Rect.Left    := Left;
  Rect.Top     := Top;
  Rect.Right   := Right;
  Rect.Bottom  := Bottom;
end;

function Bounds(X, Y, Width, Height: Single): TRect;
begin
  Result := Rect(X, Y, X + Width, Y + Height);
end;

function Circle(const Pos: TVec2f; Radius: Single): TCirclef;
begin
  Circle.Pos := Pos;
  Circle.Radius := Radius;
end;

// TLine2f//{{{
function Line2f(N: TVec2f; D: Single): TLine2f;
begin
  Line2f.N := N;
  Line2f.D := D;
end;

function Line2f(A, B: TVec2f): TLine2f;
begin
  Line2f.N := (B - A)/Len2f(B - A); 
  Line2f.N := Vec2f(- Line2f.N.Y, Line2f.N.X);
  Line2f.D := - Dot2f(A, Line2f.N);
end;

function Dist2f(Line: TLine2f; P: TVec2f): Single; overload;
begin
  Dist2f := Dot2f(Line.N, P) + Line.D;
end;
//}}}
{$IFNDEF FLAG_FPC}{$REGION 'TPoly2f'}{$ENDIF}
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
  SetLength(AsArray, Count);
  for I := 0 to Count - 1 do
    Result[I] := FPoints[I];
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
// operators//{{{
{$IFNDEF FLAG_FPC}{$REGION 'OPERATORS'}{$ENDIF}
{$IFDEF OPMATH}
operator = (A, B: TVec2i) _Result: Boolean; inline;
begin
  _Result := (A.X = B.X) and (A.Y = B.Y);
end;

operator := (A: TVec2i) _Result: TVec2f; inline;
begin
  _Result := Vec2f(A.X, A.Y)
end;

operator + (A, B: TVec2i) _Result: TVec2i; inline;
begin
  _Result := Add2i(A, B);
end;

operator + (A, B: TVec2f) _Result: TVec2f; inline;
begin
  _Result := Add2f(A, B);
end;

operator + (A, B: TVec3f) _Result: TVec3f; inline;
begin
  _Result := Add3f(A, B);
end;

operator + (A, B: TVec4f) _Result: TVec4f; inline;
begin
  _Result := Add4f(A, B);
end;

operator - (A, B: TVec2i) _Result: TVec2i; inline;
begin
  _Result := Sub2i(A, B);
end;

operator - (A, B: TVec2f) _Result: TVec2f; inline;
begin
  _Result := Sub2f(A, B);
end;

operator - (A, B: TVec3f) _Result: TVec3f; inline;
begin
  _Result := Sub3f(A, B);
end;

operator - (A, B: TVec4f) _Result: TVec4f; inline;
begin
  _Result := Sub4f(A, B);
end;

operator - (A: TVec2i) _Result: TVec2i; inline;
begin
  _Result := Vec2i(- A.X, - A.Y);
end;

operator - (A: TVec2f) _Result: TVec2f; inline;
begin
  _Result := Vec2f(- A.X, - A.Y)
end;

operator - (A: TVec3f) _Result: TVec3f; inline;
begin
  _Result := Vec3f(- A.X, - A.Y, - A.Z);
end;

operator - (A: TVec4f) _Result: TVec4f; inline;
begin
  Result := Vec4f(- A.X, - A.Y, - A.Z, - A.W);
end;

operator * (A, B: TVec2i) _Result: TVec2i; inline;
begin
  _Result := Mul2i(A, B);
end;

operator * (A, B: TVec2f) _Result: TVec2f; inline;
begin
  _Result := Mul2f(A, B);
end;

operator * (A, B: TVec3f) _Result: TVec3f; inline;
begin
  _Result := Mul3f(A, B);
end;

operator * (A, B: TVec4f) _Result: TVec4f; inline;
begin
  _Result := Mul4f(A, B);
end;

operator * (I: integer; A: TVec2i) _Result: TVec2i; inline;
begin
  _Result := Mul2i(A, I)
end;

operator * (A: TVec2i; I: Integer) _Result: TVec2i; inline;
begin
  _Result := Mul2i(A, I)
end;

operator * (S: Single; A: TVec2f) _Result: TVec2f; inline;
begin
  _Result := Mul2f(A, S)
end;

operator * (A: TVec2f; S: Single) _Result: TVec2f; inline;
begin
  _Result := Mul2f(A, S)
end;

operator * (A: TVec3f; S: Single) _Result: TVec3f; inline;
begin
  _Result := Mul3f(A, S);
end;

operator * (A: TVec4f; S: Single) _Result: TVec4f; inline;
begin
  _Result := Mul4f(A, S);
end;

operator * (S: Single; A: TVec4f) _Result: TVec4f; inline;
begin
  _Result := Mul4f(A, S);
end;

{operator div (A: TVec2i; I: Integer) _Result: TVec2i; inline;
begin
  _Result := Vec2i(A.X div I, A.Y div I);
end;}

operator / (A: TVec2f; S: Single) _Result: TVec2f; inline;
  var
    InvS: Single;
begin
  if Abs(S) < 10e-6 then
    InvS := 0
  else
    InvS := 1/S;
  _Result := Mul2f(A, InvS);
end;

operator := (V: Single) _Result: TMatrix4f; inline;
begin
  _Result := V * MatrixIdentity;
end;

operator * (A, B: TMatrix4f) _Result: TMatrix4f; inline;
begin
  _Result := MatrixMul(A, B);
end;

operator * (M: TMatrix4f; V: Single) _Result: TMatrix4f; inline;
begin
  _Result := MatrixMul(M, V);
end;

operator * (V: Single; M: TMatrix4f) _Result: TMatrix4f; inline;
begin
  _Result := M * V;
end;

operator / (M: TMatrix4f; V: Single) _Result: TMatrix4f; inline;
begin
  _Result := M * (1/V);
end;

operator * (M: TMatrix4f; V: TVec2f) _Result: TVec2f; inline;
begin
  _Result := MatrixApply(M, V);
end;

operator * (M: TMatrix4f; V: TVec3f) _Result: TVec3f; inline;
begin
  _Result := MatrixApply(M, V);
end;

operator * (M: TMatrix4f; V: TVec4f) _Result: TVec4f; inline;
begin
  _Result := MatrixApply(M, V);
end;

operator * (Q1: TQuat; Q2: TQuat) _Result: TQuat; inline;
begin
  _Result := QuatMul(Q1, Q2);
end;

operator * (Q: TQuat; V: TVec3f) _Result: TVec3f; inline;
begin
  _Result := QuatApply(Q, V);
end;

operator * (Q: TQuat; M: TMatrix4f) _Result: TMatrix4f; inline;
begin
  _Result := MatrixQuat(Q) * M;
end;

operator * (M: TMatrix4f; Q: TQuat) _Result: TMatrix4f; inline;
begin
  _Result := M * MatrixQuat(Q);
end;

operator - (Q: TQuat) _Result: TQuat; inline;
begin
  _Result := QuatInvert(Q);
end;
{$ENDIF OPMATH}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
//}}}


{var
  M: TMatrix4f;
  V: TVec3f;
initialization
  M := 5 * MatrixTranslation(Vec3f(3, 4, 5));
  Writeln(M[0][0], ' ', M[1][0], ' ', M[2][0], ' ', M[3][0]);
  Writeln(M[0][1], ' ', M[1][1], ' ', M[2][1], ' ', M[3][1]);
  Writeln(M[0][2], ' ', M[1][2], ' ', M[2][2], ' ', M[3][2]);
  Writeln(M[0][3], ' ', M[1][3], ' ', M[2][3], ' ', M[3][3]);
  V := M * Vec3f(1, 1, 1);
  Writeln(V.X, ' ', V.Y, ' ', V.Z);
  V := MatrixRotation(pi/2, Vec3f(-1/Sqrt(2), 1/Sqrt(2), 0)) * Vec3f(1, 1, 1);
  Writeln(V.X, ' ', V.Y, ' ', V.Z);
  Halt;}
end.
