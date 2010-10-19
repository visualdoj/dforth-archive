{$MODE OBJFPC}
unit DAlign;

interface

type
  TVAlign = packed record
              V: -1..1;
            end;

  THAlign = packed record
              H: -1..1;
            end;

  TAlign = record
    V: TVAlign;
    H: THAlign;
  end;

const
  HA_LEFT: THAlign         = (H:-1);
  HA_CENTER: THAlign       =  (H:0);
  HA_RIGHT: THAlign        =  (H:1);

  VA_TOP: TVAlign          = (V:-1);
  VA_CENTER: TVAlign       = (V:0);
  VA_BOTTOM: TVAlign       = (V:1);

  A_CENTER: TAlign         = (V:(V:0); H:(H:0));

operator := (H: THAlign) _Result: TAlign;
operator := (V: TVAlign) _Result: TAlign;
operator * (V: TVAlign; H: THAlign) _Result: TAlign;
operator * (H: THAlign; V: TVAlign) _Result: TAlign;

implementation

operator := (H: THAlign) _Result: TAlign;
begin
  _Result.H := H;
  _Result.V := VA_CENTER;
end;

operator := (V: TVAlign) _Result: TAlign;
begin
  _Result.H := HA_CENTER;
  _Result.V := V;
end;

operator * (V: TVAlign; H: THAlign) _Result: TAlign;
begin
  _Result.H := H;
  _Result.V := V;
end;

operator * (H: THAlign; V: TVAlign) _Result: TAlign;
begin
  _Result.H := H;
  _Result.V := V;
end;

var
  V: TVAlign;
  H: THAlign;
  A: TAlign;

initialization
  H := HA_LEFT;
  V := VA_CENTER;
  A := V*H;
  A := H*V;
  A := H;
  A := V;
  {
    а такое компилятор запретит
    A := V*V;
    A := H*H;
  }
end.
