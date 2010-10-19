unit DTexture;

interface

uses
  GL,
  GLu,
  GLext,
  DDebug,
  DUtils,
  DGraph,
  DResMan;

const
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT	= $83F0;
	GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  = $83F1;
	GL_COMPRESSED_RGBA_S3TC_DXT3_EXT  = $83F2;
	GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;

type
TCompressedType = Cardinal;

TTexFormat = class
  class function Load2D(const FileName: TString; 
                        Data: TData;
                        out W, H: Integer;
                        out Alpha: Boolean;
                        var Pixels: Pointer): Boolean; virtual;
  class function LoadCompressed2D(const FileName: TString; 
                        Data: TData;
                        out W, H: Integer;
                        out Format: TCompressedType;
                        var Pixels: Pointer): Boolean; virtual;
end;
CTexFormat = class of TTexFormat;
TListOfCTexFormat = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<CTexFormat>;

TLoader = class
private
  FFormats: TListOfCTexFormat;
public
  constructor Create;
  destructor Destroy; override;
  procedure RegistFormat(Format: CTexFormat);
  function Load2D(const FileName: TString; 
                  Data: TData;
                  out W, H: Integer;
                  out Alpha: Boolean;
                  var Pixels: Pointer): Boolean;
  function LoadCompressed2D(const FileName: TString;
                        Data: TData;
                        out W, H: Integer;
                        out Format: TCompressedType;
                        var Pixels: Pointer): Boolean; virtual;
end;

TTex = class(TResource)
private
  FGraph: TGraph;
  FTarget: GLenum;
  FId: GLuint;
  FWidth: Integer;
  FHeight: Integer;
  function Upload2DToGL(W, H: Integer; 
                        Alpha: Boolean; 
                        Pixels: Pointer): GLuint;
  function UploadCompressed2DToGL(W, H: Integer;
                        Format: TCompressedType; 
                        Pixels: Pointer): GLuint;
  procedure FreeFromGL;
public
  class function Create(Graph: TGraph; 
                        FileName: TString; 
                        Man: TResMan = nil): TTex;
  destructor Destroy; override;
  procedure Bind;
  procedure Unbind;
  property Width: Integer read FWidth;
  property Height: Integer read FHeight;
end;

var
  Loader: TLoader;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TTexFormat'}{$ENDIF}
// CTexFormat
class function TTexFormat.Load2D;
begin
  Result := False;
end;

class function TTexFormat.LoadCompressed2D(const FileName: TString; 
                      Data: TData;
                      out W, H: Integer;
                      out Format: TCompressedType;
                      var Pixels: Pointer): Boolean;
begin
  Result := False;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLoader'}{$ENDIF}
constructor TLoader.Create;
begin
  FFormats := TListOfCTexFormat.Create;
end;

destructor TLoader.Destroy;
begin
  FFormats.Free;
end;

procedure TLoader.RegistFormat;
begin
  FFormats.Add(Format);
end;

function TLoader.Load2D;
  var
    I: Integer;
begin
  for I := 0 to FFormats.Last do
    if FFormats[I].Load2D(FileName, Data, W, H, Alpha, Pixels) then begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

function TLoader.LoadCompressed2D;
  var
    I: Integer;
begin
  for I := 0 to FFormats.Last do
    if FFormats[I].LoadCompressed2D(FileName, Data, W, H, Format, Pixels) then begin
      Result := True;
      Exit;
    end;
  Result := False;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TTex'}{$ENDIF}
function TTex.Upload2DToGL;
  var
    Mipmap: Boolean;
begin
  MipMap := True;

  glGenTextures(1, @Result);
  glBindTexture(GL_TEXTURE_2D, Result);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);							// set 1-byte alignment
  
  // set texture to repeat mode
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

  if MipMap then  
    if Alpha then
      gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA8, W, H, GL_RGBA, 
                        GL_UNSIGNED_BYTE, Pixels)
    else
      gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB8, W, H, GL_RGB, 
                        GL_UNSIGNED_BYTE, Pixels)
  else
    if Alpha then 
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, W, H, 0, GL_RGBA, 
                   GL_UNSIGNED_BYTE, Pixels)
    else
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, W, H, 0, GL_RGB, 
                   GL_UNSIGNED_BYTE, Pixels);

  if MipMap then begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);    
  end else begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  end;  

  FWidth := W;
  FHeight := H;
end;

function TTex.UploadCompressed2DToGL(W, H: Integer;
                      Format: TCompressedType; 
                      Pixels: Pointer): GLuint;
var
  MipMap: Boolean;
  BlockSize: Integer;
begin
  MipMap := False;

  glGenTextures(1, @Result);
  glBindTexture(GL_TEXTURE_2D, Result);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);							// set 1-byte alignment

  // set texture to repeat mode
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

  BlockSize := 8 * (1 + Ord(Format <> GL_COMPRESSED_RGBA_S3TC_DXT1_EXT));

  glCompressedTexImage2D(GL_TEXTURE_2D, 0, Format, W, H, 0,
    ((W+3) div 4) * ((H+3) div 4) * BlockSize, Pixels);


  if MipMap then begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  end else begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  end;

  FWidth := W;
  FHeight := H;
end;                

procedure TTex.FreeFromGL;
begin
  glDeleteTextures(1, @FId);
end;

class function TTex.Create(Graph: TGraph; 
                        FileName: TString; 
                        Man: TResMan = nil): TTex;
  type
    TArrayOfByte = array[0..1] of Byte;
    PArrayOfByte = ^TArrayOfByte;
  var
    Data: TData;
    W, H, I: Integer;
    Alpha: Boolean;
    Format: TCompressedType;
    Pixels: Pointer;
begin
  if GetInstance(ClassName + ' file="' + FileName + '"', TResource(Result),
                 Man) then
    with Result do begin
      FGraph := Graph;
      FTarget := GL_TEXTURE_2D;
      if FileExist(FileName) then begin
        Data := TData.Create(FileName);

        if GL_ARB_texture_compression and
           Loader.LoadCompressed2D(FileName, Data, W,
                                   H, Format, Pixels) then begin
          FId := UploadCompressed2dToGL(W, H, Format, Pixels);
        end else
        if Loader.Load2D(FileName, Data, W, H, Alpha, Pixels) then begin
          FId := Upload2DToGL(W, H, Alpha, Pixels);
        end else
          Pixels := nil;
        Data.Free;
        FWidth := W;
        FHeight := H;
      end else
        Pixels := nil;
      if Pixels = nil then begin
        Warrning('loading faild, set default');
        FWidth := 16;
        FHeight := 16;
        W := FWidth;
        H := FHeight;
        GetMem(Pixels, W * H * 4);
        for W := 0 to 15 do
          for H := 0 to 15 do
            for I := 0 to 3 do
              PArrayOfByte(Pixels)[(W+H*16)*4+I] := 
                        Ord((W=0)or(W=15)or(H=0)or(H=15)or(W+H=15)or(W-H=15));
      end;
      FreeMem(Pixels);
    end;
end;

destructor TTex.Destroy;
begin
  FreeFromGL;
end;

procedure TTex.Bind;
begin
  if Self = nil then
    Exit;
  glEnable(FTarget);
  glBindTexture(FTarget, FId);
end;

procedure TTex.Unbind;
begin
  if Self = nil then
    Exit;
  glDisable(FTarget);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  Loader := TLoader.Create;
finalization
  Loader.Free;
end.
