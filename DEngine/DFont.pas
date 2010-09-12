unit DFont;

interface

uses
  DDebug,
  DUtils,
  DMath,
  DGraph,
  DResMan;

type
TFontMan = class;

TFont = class(TResource)
 protected
  FMan: TFontMan;
  //FID: TString;
  FFileName: TString;
  FTex: TTexture;
  FSpacing: Integer;
  FWidth: Integer;
  FHeight: Integer;
  function GetWidth: Integer; overload;
 public
  class function Create(
        TheFontMan: TFontMan; 
        TheFileName: TString; 
        TheSpacing: Integer = 0
      ): TFont;
  destructor Destroy; override;
  procedure Draw(Pos: TVec2f; Text: TString); virtual;
  function GetWidth(Text: TString): Integer; overload; virtual;
  function GetHeight(Text: TString): Integer; virtual;
  function GetSize: TVec2i;
  //property ID: TString read FID;
  property FileName: TString read FFileName;
  property Spacing: Integer read FSpacing;
  property Width: Integer read GetWidth;
  property Height: Integer read FHeight;
end;

TFontMan = class(TResMan)
private
  FGraph: TGraph;
public
  constructor Create(Graph: TGraph);
  function CreateFont(FileName: TString; Spacing: Integer = 0): TFont;
  property Graph: TGraph read FGraph;
end;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TFont'}{$ENDIF}
function TFont.GetWidth: Integer;
begin
  Result := FWidth + FSpacing;
end;

class function TFont.Create(
        TheFontMan: TFontMan; 
        TheFileName: TString; 
        TheSpacing: Integer = 0
      ): TFont;
begin
  if GetInstance(ClassName + ' file="' + TheFileName + '"' 
                           + ' spacing="' + IntToStr(TheSpacing) + '"',
                 TResource(Result), TheFontMan) then 
    with Result do begin
      FMan := TheFontMan;
      FFileName := TheFileName;
      //FID := ClassName + '[' + FFileName + '][' + IntToStr(Spacing) + ']';
      FTex := FMan.Graph.LoadTex(FFileName);
      FWidth := FMan.Graph.TexWidth(FTex) div 16;
      FHeight := FMan.Graph.TexHeight(FTex) div 16;
      FSpacing := TheSpacing;
    end;
  Log('font loading...');
end;

destructor TFont.Destroy; 
begin
  inherited;
end;

procedure TFont.Draw(Pos: TVec2f; Text: TString);
  var
    I: Integer;
    T: TVec2f;
    R: TRect;
begin
  FMan.Graph.SetTexture(FTex);
  for I := 1 to Length(Text) do begin
    T.X := (Ord(Text[I]) mod 16)/16;
    T.Y := (Ord(Text[I]) div 16)/16;
    R := Rect(Pos, Pos + Vec2f(FWidth, FHeight));
    R.A.X := Trunc(R.A.X);
    R.A.Y := Trunc(R.A.Y);
    R.B.X := Trunc(R.B.X);
    R.B.Y := Trunc(R.B.Y);
    //SDebug.Log(ToStr([R.A.X, ' ', R.A.Y, ' ', R.B.X, ' ', R.B.Y]));
    FMan.Graph.DrawTexture(R, Rect(T, T + Vec2f(1, 1)/16));
    Pos.X := Pos.X + FWidth + Spacing;
  end;
  FMan.Graph.SetTexture(-1);
end;

function TFont.GetWidth(Text: TString): Integer;
begin
  Result := Length(Text) * (FWidth + FSpacing);
end;

function TFont.GetHeight(Text: TString): Integer;
begin
  Result := Height;
end;

function TFont.GetSize: TVec2i;
begin
  Result := Vec2i(GetWidth, FHeight);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

// TFontMan//{{{
constructor TFontMan.Create(Graph: TGraph);
begin
  inherited Create;
  FGraph := Graph;
end;

function TFontMan.CreateFont;
begin
  Result := TFont.Create(Self, FileName, Spacing);
end;
//}}}

end.
