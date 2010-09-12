unit DSound;

interface

uses
  //MMSystem,
  OpenAL,
  uFMOD,

  DUtils,
  DDebug,
  DMath;

const
  SND_NO = -1;

type
TSoundItem = record
  FileName: TString; 
  Buffer: TALuint;
  ID: TALuint;
  Refs: Integer;
end;

TSoundID = Integer;

TSound = class//{{{
private
  FOpenAL: Boolean;
  FDevice: TALCdevice;
  FContext: TALCContext;
  FSounds: array of TSoundItem;
  FMusicVolume: Single;
  procedure SetSoundVolume(Volume: Single);
  procedure SetMusicVolume(Volume: Single);
  function GetMusicPattern: Cardinal;
  procedure SetMusicPattern(MusicPattern: Cardinal);
public
  constructor Create;
  destructor Destroy; override;
  function LoadSound(FileName: TString): TSoundID;
  procedure DelSound(ID: TSoundID);
  procedure PlaySound(ID: TSoundID); overload;
  procedure PlaySound(FileName: TString); overload;
  procedure PlaySoundMMSystem(FileName: TString);
  function IsPlaying(ID: TSoundID): Boolean;
  procedure PlayMusic(FileName: TString);
  property SoundVolume: Single write SetSoundVolume;
  property MusicVolume: Single read FMusicVolume write SetMusicVolume;
  property MusicPattern: Cardinal write SetMusicPattern;
end;
//}}}
 
implementation

const
  OpenAL = 'OpenAL32.dll';

procedure TSound.SetSoundVolume(Volume: Single);//{{{
begin
  if not FOpenAL then
    Exit;
  alListenerf(AL_GAIN, Volume);
end;
//}}}
procedure TSound.SetMusicVolume(Volume: Single);//{{{
begin
  Volume := Max(0.0, Min(1.0, Volume));
  FMusicVolume := Volume;
  uFMOD_SetVolume(uFMOD_MIN_VOL + Round(Volume*(uFMOD_MAX_VOL-uFMOD_MIN_VOL)));
end;

//}}}
function TSound.GetMusicPattern: Cardinal;//{{{
begin
  Result := 0;
end;

//}}}
procedure TSound.SetMusicPattern(MusicPattern: Cardinal);//{{{
begin
  uFMOD_Jump2Pattern(MusicPattern);
end;

//}}}
constructor TSound.Create;//{{{
begin
  // uFMOD initialization
  MusicVolume := 1.0;

  // OpenAL initialization
  FOpenAL := False;
  if not InitOpenAL(OpenAL, 'alut.dll') then begin
    SDebug.Warrning('OpenAL initialization failed');
    Exit;
  end;
  
  FDevice  := alcOpenDevice(Nil);
  FContext := alcCreateContext(FDevice, Nil);
  alcMakeContextCurrent(FContext);  
  
  SDebug.Log('OpenAL initialization passed');
  FOpenAL := True;
end;

//}}}
destructor TSound.Destroy;//{{{
begin
  if not FOpenAL then
    Exit;
  alcMakeContextCurrent(Nil);
  alcDestroyContext(FContext);
  alcCloseDevice(FDevice);  
end;

//}}}
function TSound.LoadSound(FileName: TString): TSoundID;//{{{
  var
    Format: TALenum;
    Size: TALsizei;
    Data: TALvoid;
    Freq: TALsizei;
    Loop: TALint;    
    Zero: TVec4f;
    Free: TSoundID;
begin
  if not FOpenAL then
    Exit;
  Result := 0;
  Free := -1;
  while Result < Length(FSounds) do
    if FSounds[Result].FileName = FileName then begin 
      Inc(FSounds[Result].Refs);
      Exit;
    end else begin
      if FSounds[Result].FileName = '' then
        Free := Result;
      Inc(Result);
    end;
  if Free <> -1 then
    Result := Free
  else
    SetLength(FSounds, Length(FSounds) + 1);
  FSounds[Result].FileName := FileName;
  with FSounds[Result] do begin
    alGenBuffers (1, @Buffer);
    if alGetError <> AL_NO_ERROR then
      exit;
    alutLoadWAVFile (FileName, Format, Data, Size, Freq, Loop); // TODO: release
    alBufferData    (Buffer, Format, Data, Size, Freq);
    alutUnloadWAV   (Format, Data, Size, Freq); // TODO: release
    alGenSources (1, @Id);
    alSourcef (Id, AL_PITCH, 1.0);
    alSourcef (Id, AL_GAIN, 1.0);
    Zero := Vec4f(0.0, 0.0, 0.0, 0.0);    
    alSourcefv(Id, AL_POSITION, @Zero);
    alSourcefv(Id, AL_VELOCITY, @Zero);
    alSourcei(Id, AL_LOOPING, 0);
    alSourcei(Id, AL_BUFFER, Buffer);
    Refs := 1;
  end;
  //SDebug.Log(ToStr(['Loaded sound "', FileName, '"']));
  Debug.Added('sound filename="' + FileName + '"');
end;

//}}}
procedure TSound.DelSound(ID: TSoundID);//{{{
begin
  if not FOpenAL then
    Exit;
  with FSounds[ID] do begin
    Dec(Refs);
    if Refs > 0 then
      Exit;
    alDeleteSources(1, @Id);    
    alDeleteBuffers(1, @Buffer);
    FileName := '';
  end;
end;

//}}}
procedure TSound.PlaySound(ID: TSoundID);//{{{
begin
  if not FOpenAL then
    Exit;
  alSourcePlay(FSounds[ID].Id);
end;

//}}}
procedure TSound.PlaySound(FileName: TString);//{{{
  var
    ID: Integer;
begin
  if not FOpenAL then
    Exit;
  ID := LoadSound(FileName);
  PlaySound(ID);
end;

//}}}
procedure TSound.PlaySoundMMSystem(FileName: TString);//{{{
begin
  // не поддерживет одновременное проигрывание нескольких звуков
  {if FileName = '' then
    MMSystem.PlaySound(nil, 0, 0)
  else
    MMSystem.PlaySound(PChar(FileName), 0, SND_ASYNC);}
end;
//}}}
function TSound.IsPlaying(ID: TSoundID): Boolean;//{{{
  var
    Param: Integer;
begin
  alGetSourcei(FSounds[ID].ID, AL_PLAYING, @Param);
  Result := Param > 0;
end;
//}}}
procedure TSound.PlayMusic(FileName: TString);//{{{
begin
  if FileName = '' then
    uFMOD_StopSong
  else    
    uFMOD_PlaySong(PAnsiChar(FileName), 0, XM_FILE);
end;

//}}}

end.
