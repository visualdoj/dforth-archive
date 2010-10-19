unit DFormatOGG;

interface

uses
  openal,
  DUtils,
  DDebug,
  DAudio;

const
  OGG_BLOCK_SIZE = 64 * 1024;
  OGG_BLOCKS_COUNT = 4;

type
  PVorbisInfo = ^TVorbisInfo;
  TVorbisInfo = packed record
    version         : Integer;
    channels        : Integer;
    rate            : Integer;
    bitrate_upper   : Integer;
    bitrate_nominal : Integer;
    bitrate_lower   : Integer;
    bitrate_window  : Integer;
    codec_setup     : Pointer;
  end;

  TOggSyncState = packed record
    Data: Pointer;
    Storage: Integer;
    Fill: Integer;
    Returned: Integer;
    Unsynced: Integer;
    HeaderBytes: Integer;
    BodyBytes: Integer;
  end;

  POggVorbisFile = ^TOggVorbisFile;
  TOggVorbisFile = record
    {datasource: Pointer;
    seekable: Integer;
    offset: Int64;
    _end: Int64;
    oy: toggSyncState;
    links: Integer;
    offsets: PInt64;
    dataoffsets: PInt64;
    serialnos: PInteger;
    pcmlengths: Int64;}
    some: array[0..17] of Integer;
    vi: PVorbisInfo;
    // переписывать описание всего остального - наказание >_< Благо, это не нужно
    other: array[0..700] of Byte;
  end;

TOGGPlayer = class(TMusicPlayer)
 private
  //FVolume: Single;
  FData: TData;
  FSourceID: TALuint;
  FOggVorbisFile: POggVorbisFile;
  FBlockSize: Integer;
  FBlocks: array[0..OGG_BLOCKS_COUNT-1] of TALuint;
  FLooped: Boolean;
  FFormat: Integer;
  FRate: Integer;

  FDevice: TALCdevice;
  FContext: TALCContext;

  function ReadOggBlock(BufID: TALuint; Format, Rate: Cardinal; Size: Integer): Boolean;
 public
  constructor Create;
  destructor Destroy; override;
  function OnLoad(const FileName: TString): Boolean; override;
  procedure OnPlay; override;
  procedure OnStop; override;
  procedure OnPause; override;
  procedure OnUpdate; override;
  procedure SetVolume(Volume: Single); override;
  function GetVolume: Single; override;
end;

TOGGFormat = class(TMusicFormat)
 protected
  procedure DoCreate; override;
 public
  function Load(const FileName: TString): TMusicPlayer; override;
end;

implementation

// TODO: сделать кросскомпилерную работу с дин. библиотеками
uses
  dynlibs;

{$IFNDEF FLAG_FPC}{$REGION 'vorbisfile'}{$ENDIF}
// TODO: возможность настраивать путь к файлу в real-time
const
  VorbisfileLib = 'vorbisfile.dll';

  SEEK_SET      = 0;
  SEEK_CUR      = 1;
  SEEK_END      = 2;

type
  TOVCallbacks = record
    read_func  : function(var ptr; size: Cardinal; nmemb: Cardinal; const datasource): Cardinal; cdecl;
    seek_func: function (Datasource: Pointer; offset: Int64; whence: Integer): Integer; cdecl;
    close_func: function (Datasource: Pointer): Integer; cdecl;
    tell_func: function (Datasource: Pointer): Integer; cdecl;
  end;  

var
  OVCallbacks: TOVCallbacks;
  
  VorbisHandle: TLibHandle;
  //ov_clear: function(OggFile: Pointer): Integer; cdecl; {external VorbisfileLib;}
//  function ov_open_callbacks(Datasource: Pointer; OggFile: Pointer; initial: PChar; ibytes: Integer; callbacks: TOVCallbacks): Integer; cdecl; external VorbisFileLib;
  ov_open_callbacks: function(const datasource; OggFile: Pointer; initial: PChar; ibytes: Integer; callbacks: TOVCallbacks): Integer; cdecl; (* external VorbisFileLib; *)
  ov_pcm_seek: function(OggFile: Pointer; pos: Int64): Integer; cdecl; (* external VorbisFileLib; *)
  ov_read: function(OggFile: Pointer; Buffer: Pointer; length: Integer; bigendianp: Integer; word: Integer; sgned: Integer; bitstream: Pointer): Integer; cdecl; (* external VorbisFileLib; *)

function read_func(var ptr; size, nmemb: Cardinal; const datasource): Cardinal; cdecl;
begin
  Result := TData(Datasource).Size - TData(Datasource).Pos;
  if Result > Size * Nmemb then
    Result := Size * Nmemb;
  //Log('read_func: ' + IntToStr(Result));
  try
    TData(Datasource).ReadVar(@Ptr, Result);
    Result := Int64(Result) div Int64(Size);
  except
    Error('[DFormatOGG.pas:read_func] exception in TData(Datasource).ReadVar');
    Result := 0;
  end;
end;

function seek_func(Datasource: Pointer; Offset: Int64; whence: Integer): Integer; cdecl;
begin
  // TODO: обработка некорректного Offset
  Result := 0;
  case whence of
    SEEK_SET: 
      begin
        TData(Datasource^).SeekAbs(Offset);
      end;
    SEEK_CUR: TData(Datasource^).Seek(Offset);
    SEEK_END: TData(Datasource^).SeekAbs(TData(Datasource^).Size - Offset);
  end;
end;

function close_func(Datasource: Pointer): Integer; cdecl;
begin
  Result := 0;
end;

function tell_func(Datasource: Pointer): Integer; cdecl;
begin
  Result := TData(Datasource^).Pos;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TOGGPlayer'}{$ENDIF}
constructor TOGGPlayer.Create;
begin
  FData := nil;
  FLooped := True;

  GetMem(FOggVorbisFile, SizeOf(TOggVorbisFile));

  // TODO: TEMPORARY, вынести в класс TOpenAL
  if not InitOpenAL('OpenAL32.dll', 'alut.dll') then begin
    Debug.Warrning('OpenAL initialization failed');
  end;
  
  FDevice  := alcOpenDevice(Nil);
  FContext := alcCreateContext(FDevice, Nil);
  alcMakeContextCurrent(FContext);    
  /////////////////////////////////////////

  alGenSources(1, @FSourceID);
  alSourcef(FSourceID, AL_PITCH, 1.0);
  alSourcef(FSourceID, AL_GAIN, 1.0);
end;

destructor TOGGPlayer.Destroy;
begin
  if FData <> nil then
    FData.Free;
  FreeMem(FOggVorbisFile);
end;

function TOGGPlayer.ReadOggBlock(BufID: TALuint; Format, Rate: Cardinal; Size: Integer): Boolean;
  var
    PCM: PArrayOfByte;
    Readed, Temp: Integer;
begin
  GetMem(PCM, Size);
  Readed := 0;
  while Readed < Size do begin
    Temp := ov_read(FOggVorbisFile, @(PCM^[Readed]), Size - Readed, 0, 2, 1, nil);
    if Temp <= 0 then
      Break;
    Inc(Readed, Temp);
  end;
  {repeat
    Temp := ov_read(FOggVorbisFile, @(PCM^[Readed]), Size - Readed, 0, 2, 1, nil);
    Inc(Readed, Temp);
  until (Temp = 0) or (Readed = Size);}
  alBufferData(BufID, Format, PCM, Readed, Rate);
  FreeMem(PCM);
  Result := Temp > 0;
  if Temp < 0 then
    Error('TOGGPlayer.ReadOggBlock: ov_read return error code ' + IntToStr(Temp));
end;

function TOGGPlayer.OnLoad;
  var
    I: Integer;
begin
  Result := False;
  if FData <> nil then
    FData.Free;
  if Pos('.ogg', FileName) <> Length(FileName) - 3 then
    Exit;
  FData := TData.Create(FileName);
  //if not FData.Ready then
  //  Exit;
  if ov_open_callbacks(Pointer(FData), FOggVorbisFile, nil, 0, OVCallbacks) < 0 then begin
    FData.Free;
    FData := nil;
    Exit;
  end;
  FBlockSize := OGG_BLOCK_SIZE;
  alSourcei(FSourceID, AL_LOOPING, AL_FALSE);
  if FOggVorbisFile.VI^.Channels = 1 then 
    FFormat := AL_FORMAT_MONO16 
  else 
    FFormat := AL_FORMAT_STEREO16;
  FRate := FOggVorbisFile.VI^.Rate;
  for I := 0 to OGG_BLOCKS_COUNT - 1 do begin
    alGenBuffers(1, @FBlocks[I]);
    ReadOggBlock(FBlocks[I], FFormat, FRate, OGG_BLOCK_SIZE);
    alSourceQueueBuffers(FSourceId, 1, @FBlocks[I]); 
  end;
  Result := True;
end;

procedure TOGGPlayer.OnPlay; 
begin
  alSourcePlay(FSourceID);
end;

procedure TOGGPlayer.OnStop;
begin
end;

procedure TOGGPlayer.OnPause;
begin
end;

var
  Param: Integer;
procedure TOGGPlayer.OnUpdate; 
  var
    Processed: Integer;
    BufId: TALuint;
    ALError: TALEnum;
begin
  alGetSourcei(FSourceID, AL_SOURCE_STATE, @Param);
  if Param <> AL_PLAYING then
    alSourcePlay(FSourceID);
  alGetSourcei(FSourceID, AL_BUFFERS_PROCESSED, @Processed);
  while Processed > 0 do begin
    alSourceUnqueueBuffers(FSourceID, 1, @BufId);
    if ReadOggBlock(BufId, FFormat, FRate, OGG_BLOCK_SIZE) then
      alSourceQueueBuffers(FSourceID, 1, @BufId)
    else begin
      alSourceQueueBuffers(FSourceID, 1, @BufId);
      ov_pcm_seek(FOggVorbisFile, 0);
      //if not FLooped then
      //  Stop;
    end;
    Dec(Processed);
  end;
  ALError := alGetError;
  while ALError <> AL_NO_ERROR do begin
    Error('TOGGPlayer.OnUpdate: $' + IntToHex(ALError));
    ALError := alGetError;
  end;
end;

procedure TOGGPlayer.SetVolume(Volume: Single); 
begin
end;

function TOGGPlayer.GetVolume: Single;
begin
  Result := 0;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TOGGFormat'}{$ENDIF}
procedure TOGGFormat.DoCreate;
begin
  // инициализация всяких библиотек
end;

function TOGGFormat.Load(const FileName: TString): TMusicPlayer;
begin
  Result := TOGGPlayer.Create;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  AudioFormats.RegistMusicFormat(TOGGFormat);
  OVCallbacks.read_func := read_func;
  OVCallbacks.seek_func := seek_func;
  OVCallbacks.tell_func := tell_func;
  OVCallbacks.close_func := close_func;

  VorbisHandle := LoadLibrary(VorbisfileLib);
  if VorbisHandle <> NilHandle then begin
    // ov_clear := GetProcAddress(VorbisHandle, 'ov_clear');
    ov_open_callbacks := GetProcAddress(VorbisHandle, 'ov_open_callbacks');
    ov_pcm_seek := GetProcAddress(VorbisHandle, 'ov_pcm_seek');
    ov_read := GetProcAddress(VorbisHandle, 'ov_read');
  end;
finalization
  if VorbisHandle <> NilHandle then
    FreeLibrary(VorbisHandle);
end.
