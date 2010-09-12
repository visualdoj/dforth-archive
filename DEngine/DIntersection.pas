unit DIntersection;

interface

uses
  DUtils,
  DDebug,
  DMath;

type
  TRange0To2 = 0..2;

function Contain(A, B: TRect): Boolean;
function Intersect(A, B: TRect): Boolean; overload;
function Intersect(R: TRect; X1, X2, Y: Single): Boolean; overload;
// Delta - такой минимальный сдвиг R, чтобы R и A пересеклись 
function Intersect(R: TRect; A: TVec2f; var Delta: TVec2f): Boolean; overload;
function Intersect(R: TRect; A: TVec2f): Boolean; overload;

function Intersect(Line: TLine2f; Rect: TRect;
                   var T: Single): Boolean; overload;
function Intersect(Pos, Dir: TVec2f; Rect: TRect;
                   var T: Single): Boolean; overload;
function Intersect(
      const Line: TLine2f;
      const Circle: TCirclef;
      out Point1: TVec2f;
      out Point2: TVec2f
    ): Boolean; overload;
function Intersect(
      const A, B: TVec2f;
      const Circle: TCirclef;
      out Point1: TVec2f;
      out Point2: TVec2f
    ): TRange0To2; overload;
function Intersect(
      Poly: TPoly2f;
      const Circle: TCirclef;
      out Points: TArrayOfVec2f
    ): Boolean; overload;
function Intersect(
      Poly: TPoly2f;
      const Circle: TCirclef;
      out Point1, Point2: TVec2f
    ): Boolean; overload;
function Intersect(
      const Point: TVec2f;
      Poly: TPoly2f
    ): Boolean; overload;
function Intersect(
               const Line1, Line2: TLine2f;
                 out Point: TVec2f
             ): Boolean; overload;
function Intersect(
               const A, B, C, D: TVec2f;
                 out P: TVec2f
             ): Boolean; overload;
function Intersect(
      const Point1, Point2: TVec2f;
      Poly: TPoly2f;
      out Points: TArrayOfVec2f
    ): Boolean; overload;
function Intersect(
      const Point1, Point2: TVec2f;
      Poly: TPoly2f
    ): Boolean; overload;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'functions'}{$ENDIF}
function Contain(A, B: TRect): Boolean;
begin
  Contain := (A.A.X <= B.A.X) and (B.B.X <= A.B.X) and
             (A.A.X <= B.A.X) and (B.B.X <= A.B.X);
end;

function Intersect1D(A, B, C, D: Single): Boolean;
begin
  Intersect1D := ((A <= C)and(C <= B)) or ((A <= D)and(D <= B)) or
                 ((C <= A)and(A <= D)) or ((C <= B)and(B <= D));
end;

function Intersect(A, B: TRect): Boolean; overload;
begin
  Intersect := Intersect1D(A.A.X, A.B.X, B.A.X, B.B.X) and
               Intersect1D(A.A.Y, A.B.Y, B.A.Y, B.B.Y);
end;

function Intersect(R: TRect; X1, X2, Y: Single): Boolean;
begin
  Intersect := Intersect(R, Rect(Vec2f(X1, Y), Vec2f(X2, Y)));
end;

function Intersect(R: TRect; A: TVec2f; var Delta: TVec2f): Boolean;
begin
  if A.X > R.B.X then
    Delta.X := A.X - R.B.X
  else if A.X < R.A.X then
    Delta.X := A.X - R.A.X
  else
    Delta.X := 0.0;
  if A.Y > R.B.Y then
    Delta.Y := A.Y - R.B.Y
  else if A.Y < R.A.Y then
    Delta.Y := A.Y - R.A.Y
  else
    Delta.Y := 0.0;
  Intersect := (Delta.X = 0.0) and (Delta.Y = 0.0);
end;

function Intersect(R: TRect; A: TVec2f): Boolean;
begin
  Intersect := (R.A.X <= A.X) and (A.X <= R.B.X) and
               (R.A.Y <= A.Y) and (A.Y <= R.B.Y)
end;

function Intersect(Line: TLine2f; Rect: TRect; var T: Single): Boolean;
begin
  Result := False;
end;

function Intersect(Pos, Dir: TVec2f; Rect: TRect; var T: Single): Boolean;
  var
    Line: TLine2f;
    V: array[0..3] of record
                     P: TVec2f;
                     D: Single;
                   end;
    I: Integer;
    Temp, A, B: Single;
    P: TVec2f;
begin
  Intersect := False;
  T := 10e+10;
  V[0].P := Rect.A;
  V[1].P := Vec2f(Rect.B.X, Rect.A.Y);
  V[2].P := Rect.B;
  V[3].P := Vec2f(Rect.A.X, Rect.B.Y);
  Line := DMath.Line2f(Pos, Pos + Dir);
  //Dir := Dir / Len2f(Dir);
  for I := 0 to 3 do
    V[I].D := Dist2f(Line, V[I].P);
  for I := 0 to 3 do 
    if V[I].D * V[(I+1) mod 4].D < 0 then begin
      A := Abs(V[I].D);
      B := Abs(V[(I+1) mod 4].D);
      P := (B * V[I].P  + A * V[(I + 1) mod 4].P) / (A + B);
      Temp := Dot2f(Dir, P - Pos);
      if (0 < Temp) and (Temp < T) then begin
        T := Temp;
        Intersect := True;
      end;
    end;
end;

function Intersect(
      const Line: TLine2f;
      const Circle: TCirclef;
      out Point1: TVec2f;
      out Point2: TVec2f
    ): Boolean;
  var
    D, K: Single;
    M, N: TVec2f;
begin
  D := Dist2f(Line, Circle.Pos);
  N := Norm2f(Line.N);
  Result := Abs(D) < Circle.Radius;
  if Result then begin
    M := Circle.Pos - D * Line.N;
    K := Sqrt(Sqr(Circle.Radius) - Sqr(D));
    Point1 := M + (-K) * Vec2f(N.Y, - N.X);
    Point2 := M + ( K) * Vec2f(N.Y, - N.X);
    //Log('Dist to line: ' + FloatToStr(Dist2f(Line, M)) + '   ' +
    //    'Dist to circle: ' + FloatToStr(Circle.Radius - 
    //                                    Len2f(Point1 - Circle.Pos)));
  end;
end;

function Intersect(
      const A, B: TVec2f;
      const Circle: TCirclef;
      out Point1: TVec2f;
      out Point2: TVec2f
    ): TRange0To2; 
  var
    L: TLine2f;
    DirD: TVec2f;
    Dot1, Dot2, LenD: Single;
begin
  L := Line2f(A, B);
  LenD := Len2f(B - A);
  DirD := (B - A) / LenD;
  if Intersect(L, Circle, Point1, Point2) then begin
    Dot1 := Dot2f(DirD, Point1 - A);
    Dot2 := Dot2f(DirD, Point2 - A);
    if (Dot1 < 0) or (Dot1 > LenD) then begin
      Point1 := Point2;
      Dot1 := Dot2;
      Dot2 := -1;
    end;
    if (Dot1 < 0) or (Dot1 > LenD) then
      Result := 0
    else if (Dot2 < 0) or (Dot2 > LenD) then
      Result := 1
    else
      Result := 2;
  end else
    Result := 0;
end;

function Intersect(
      Poly: TPoly2f;
      const Circle: TCirclef;
      out Points: TArrayOfVec2f
    ): Boolean;
  var
    I: Integer;
    Point1, Point2: TVec2f;
begin
  SetLength(Points, 0);
  for I := 0 to Poly.Count - 1 do
    case Intersect(Poly[I], Poly[I+1], Circle, Point1, Point2) of
      1:
        begin
          SetLength(Points, Length(Points) + 1);
          Points[High(Points)] := Point1;
        end;
      2:
        begin
          SetLength(Points, Length(Points) + 2);
          Points[High(Points) - 1] := Point1;
          Points[High(Points)] := Point2
        end;
    end;
  Result := Length(Points) > 0;
end;

function Intersect(
      Poly: TPoly2f;
      const Circle: TCirclef;
      out Point1, Point2: TVec2f
    ): Boolean;
  var
    Points: TArrayOfVec2f;
begin
  Intersect(Poly, Circle, Points);
  Result := Length(Points) >= 2;
  if Result then begin
    Point1 := Points[0];
    Point2 := Points[1];
  end;
end;

function Intersect(
      const Point: TVec2f;
      Poly: TPoly2f
    ): Boolean;
  var
    I: Integer;
    L: TLine2f;
begin
  Result := Poly.Count > 2;
  if not Result then
    Exit;
  for I := 0 to Poly.Count - 1 do begin
    L := Line2f(Poly[I], Poly[I+1]);
    if Dist2f(L, Point) * Dist2f(L, Poly[I+2]) < 0 then begin
      Result := False;
      Exit;
    end;
  end;
end;

function Intersect(
               const Line1, Line2: TLine2f;
                 out Point: TVec2f
             ): Boolean;
  var
    D: Single;
begin
  {$IFDEF FLAG_DEBUG}
  //Assert(Abs(Len2f(Line1.N) - 1) < EPS, 'Intersect Line1 vs Line2: incorrect Line1');
  //Assert(Abs(Len2f(Line2.N) - 1) < EPS, 'Intersect Line1 vs Line2: incorrect Line2');
  {$ENDIF}
  D := Line1.N.X*Line2.N.Y - Line2.N.X*Line1.N.Y;
  Result := Abs(D) > EPS * 10000;
  if Result then begin
    Point.X := (Line2.D*Line1.N.Y - Line1.D*Line2.N.Y) / D;
    Point.Y := (Line1.D*Line2.N.X - Line2.D*Line1.N.X) / D;
    {$IFDEF FLAG_DEBUG}
    if (not Assert(Abs(Dist2f(Line1, Point)) < EPS*1000, 'Intersect Line1 vs Line2: результирующая точка не лежит на Line1')) or
       (not Assert(Abs(Dist2f(Line2, Point)) < EPS*100, 'Intersect Line1 vs Line2: результирующая точка не лежит на Line2')) then begin
      Log('1: (' + FloatToStr(Line1.N.X) + ' ' + FloatToStr(Line1.N.Y) + ' ' +
                   FloatToStr(Line1.D) + ')');
      Log('2: (' + FloatToStr(Line2.N.X) + ' ' + FloatToStr(Line2.N.Y) + ' ' +
                   FloatToStr(Line2.D) + ') '); 
      Log(FloatToStr(Point.X) + ' ' + FloatToStr(Point.Y));
    end;
    {$ENDIF}
  end;
end;

function Intersect(
               const A, B, C, D: TVec2f;
                 out P: TVec2f
             ): Boolean;
  var
    L1, L2: TLine2f;
    R1, R2: TRectf;
begin
  L1 := Line2f(A, B);//GetNormal2f(A, B), - Dot2f(GetNormal2f(A, B), A));
  L2 := Line2f(C, D);//GetNormal2f(C, D), - Dot2f(GetNormal2f(C, D), C));
  Result := Intersect(L1, L2, P);
  if Result then begin
    R1.A := Vec2f(Min(A.X, B.X) - EPS, Min(A.Y, B.Y) - EPS);
    R1.B := Vec2f(Max(A.X, B.X) + EPS, Max(A.Y, B.Y) + EPS);
    R2.A := Vec2f(Min(C.X, D.X) - EPS, Min(C.Y, D.Y) - EPS);
    R2.B := Vec2f(Max(C.X, D.X) + EPS, Max(C.Y, D.Y) + EPS);
    Result := Intersect(R1, P) and Intersect(R2, P);
  end;
end;

function Intersect(
      const Point1, Point2: TVec2f;
      Poly: TPoly2f;
      out Points: TArrayOfVec2f
    ): Boolean;
  var
    I: Integer;
    P: TVec2f;
begin
  SetLength(Points, 0);
  if Len2f(Point1 - Point2) < EPS*2 then begin
    Result := False;
    Exit;
  end;
  for I := 0 to Poly.Count - 1 do
    if Intersect(Point1, Point2, Poly[I], Poly[I+1], P) then begin
      SetLength(Points, Length(Points) + 1);
      Points[High(Points)] := P;
    end;
  Result := Length(Points) > 0;
end;

function Intersect(
      const Point1, Point2: TVec2f;
      Poly: TPoly2f
    ): Boolean;
  var
    Points: TArrayOfVec2f;
begin
  Result := Intersect(Point1, Point2, Poly, Points);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.
