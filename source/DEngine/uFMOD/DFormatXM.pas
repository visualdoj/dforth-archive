unit DFormatXM;

interface

uses
  DUtils,
  DAudio;

type
TXMPlayer = class(TMusicPlayer)
 private
  FVolume: Single;
 public
  constructor Create;
  function OnLoad(const FileName: TString): Boolean; override;
  procedure OnPlay; override;
  procedure OnStop; override;
  procedure OnPause; override;
  procedure SetVolume(Volume: Single); override;
  function GetVolume: Single; override;
end;

TXMFormat = class(TMusicFormat)
 protected
  procedure DoCreate; override;
 public
  function Load(const FileName: TString): TMusicPlayer; override;
end;

implementation

uses
  uFMOD;

{$IFNDEF FLAG_FPC}{$REGION 'TXMPlayer'}{$ENDIF}
constructor TXMPlayer.Create;
begin
  FVolume := (uFMOD_DEFAULT_VOL - uFMOD_MIN_VOL)/(uFMOD_MAX_VOL - uFMOD_MIN_VOL);
end;

function TXMPlayer.OnLoad;
begin
  Result := uFMOD_PlaySong(
                  PAnsiChar(FileName), 
                  0, 
                  XM_FILE or XM_SUSPENDED
                ) <> nil;
end;

procedure TXMPlayer.OnPlay; 
begin
  uFMOD_Resume;
end;

procedure TXMPlayer.OnStop;
begin
  uFMOD_StopSong;
end;

procedure TXMPlayer.OnPause;
begin
  uFMOD_Pause;
end;

procedure TXMPlayer.SetVolume(Volume: Single); 
begin
  uFMOD_SetVolume(uFMOD_MIN_VOL + Round(Volume * uFMOD_MAX_VOL));
end;

function TXMPlayer.GetVolume: Single;
begin
  Result := FVolume;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TXMFormat'}{$ENDIF}
procedure TXMFormat.DoCreate;
begin
end;

function TXMFormat.Load(const FileName: TString): TMusicPlayer;
begin
  Result := TXMPlayer.Create;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  AudioFormats.RegistMusicFormat(TXMFormat);
end.
