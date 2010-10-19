unit openal;

interface

uses
  windows;

const
  //Indicate the gain (volume amplification) applied.
  //Type:   ALfloat.
  //Range:  ]0.0-  ]
  //A value of 1.0 means un-attenuated/unchanged.
  //Each division by 2 equals an attenuation of -6dB.
  //Each multiplicaton with 2 equals an amplification of +6dB.
  //A value of 0.0 is meaningless with respect to a logarithmic
  //scale; it is interpreted as zero volume - the channel
  //is effectively disabled.
  AL_GAIN                                   =$100A;

  AL_FALSE                                  = 0;  
  AL_TRUE                                   = 1;

  AL_NO_ERROR                               =AL_FALSE;

  //Specify the pitch to be applied, either at source,
  //or on mixer results, at listener.
  //Range:   [0.5-2.0]
  //Default: 1.0
  AL_PITCH                                  =$1003;

  //Specify the current location in three dimensional space.
  //OpenAL, like OpenGL, uses a right handed coordinate system,
  //where in a frontal default view X (thumb) points right,
  //Y points up (index finger), and Z points towards the
  //viewer/camera (middle finger).
  //To switch from a left handed coordinate system, flip the
  //sign on the Z coordinate.
  //Listener position is always in the world coordinate system.
  AL_POSITION                               =$1004;

  //Specify the current direction.
  AL_DIRECTION                              =$1005;

  // Specify the current velocity in three dimensional space.
  AL_VELOCITY                               =$1006;

  //Indicate whether source is looping.
  //Type: ALboolean?
  //Range:   [AL_TRUE, AL_FALSE]
  //Default: FALSE.
  AL_LOOPING                                =$1007;

  //Indicate the buffer to provide sound samples.
  //Type: ALuint.
  //Range: any valid Buffer id.
  AL_BUFFER                                 =$1009;

  //Source state information.
  AL_SOURCE_STATE                           =$1010;
  AL_INITIAL                                =$1011;
  AL_PLAYING                                =$1012;
  AL_PAUSED                                 =$1013;
  AL_STOPPED                                =$1014;

  // Sound buffers: format specifier.
  AL_FORMAT_MONO8                           =$1100;
  AL_FORMAT_MONO16                          =$1101;
  AL_FORMAT_STEREO8                         =$1102;
  AL_FORMAT_STEREO16                        =$1103;

  //Buffer Queue params
  AL_BUFFERS_QUEUED                         =$1015;
  AL_BUFFERS_PROCESSED                      =$1016;

type
{$IFNDEF FLAG_FPC}{$REGION 'types'}{$ENDIF}
  // OpenAL boolean type.
  TALboolean = Boolean;
  PALboolean = ^TALboolean;
  // OpenAL 8bit signed byte.
  TALbyte = ShortInt;
  PALbyte = ^TALbyte;
  PPALbyte = ^PALbyte;
  // OpenAL 8bit unsigned byte.
  TALuByte = Char;
  PALuByte = PChar;
  // OpenAL 16bit signed short integer type.
  TALshort = SmallInt;
  PALshort = ^TALshort;
  // OpenAL 16bit unsigned short integer type.
  TALushort = Word;
  PALushort = ^TALushort;
  // OpenAL 32bit unsigned integer type.
  TALuint = Cardinal;
  PALuint = ^TALuint;
  // OpenAL 32bit signed integer type.
  TALint = Integer;
  PALint = ^TALint;
  // OpenAL 32bit floating point type.
  TALfloat = Single;
  PALfloat = ^TALfloat;
  // OpenAL 64bit double point type.
  TALdouble = Double;
  PALdouble = ^TALdouble;
  // OpenAL 32bit type.
  TALsizei = Cardinal;
  PALsizei = ^TALsizei;
  // OpenAL void type
  TALvoid = Pointer;
  PALvoid = ^TALvoid;
  PPALvoid = ^PALvoid;
  // OpenAL enumerations.
  TALenum = Integer;
  PALenum = ^TALenum;
  // OpenAL bitfields.
  TALbitfield = Cardinal;
  PALbitfield = ^TALbitfield;
  // OpenAL clamped float.
  TALclampf = TALfloat;
  PALclampf = ^TALclampf;
  // Openal clamped double.
  TALclampd = TALdouble;
  PALclampd = ^TALclampd;

  // ALC enumerations.
  TALCenum = integer;
  PALCenum = ^TALCenum;
  // ALC boolean type.
  TALCboolean = boolean;
  PALCboolean = ^TALCboolean;
  // ALC 8bit signed byte.
  TALCbyte = ShortInt;
  PALCbyte = ^TALCbyte;
  // ALC 8bit unsigned byte.
  TALCubyte = Char;
  PALCubyte = PChar;
  // ALC 16bit signed short integer type.
  TALCshort = smallint;
  PALCshort = ^TALCshort;
  // ALC 16bit unsigned short integer type.
  TALCushort = Word;
  PALCushort = ^TALCushort;
  // ALC 32bit unsigned integer type.
  TALCuint = Cardinal;
  PALCuint = ^TALCuint;
  // ALC 32bit signed integer type.
  TALCint = integer;
  PALCint = ^TALCint;
  // ALC 32bit floating point type.
  TALCfloat = single;
  PALCfloat = ^TALCfloat;
  // ALC 64bit double point type.
  TALCdouble = double;
  PALCdouble = ^TALCdouble;
  // ALC 32bit type.
  TALCsizei = integer;
  PALCsizei = ^TALCsizei;
  // ALC void type
  TALCvoid = Pointer;
  PALCvoid = ^TALCvoid;
  // ALC device
  TALCdevice = TALCvoid;
  PALCdevice = ^TALCdevice;
  // ALC context
  TALCcontext = TALCvoid;
  PALCcontext = ^TALCcontext;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

var
  alGetProcAddress: function(fname: PALuByte): Pointer; cdecl;

  alBufferData: procedure(buffer: TALuint; format: TALenum; data: Pointer; size, freq: TALsizei); cdecl;
  alDeleteBuffers: procedure(n: TALsizei; buffers: PALuint); cdecl;
  alDeleteSources: procedure(n: TALsizei; sources: PALuint); cdecl;
  alGenBuffers: procedure(n: TALsizei; buffers: PALuint); cdecl;
  alGenSources: procedure(n: TALsizei; sources: PALuint); cdecl;
  alGetError: function: TALenum; cdecl;
  alGetSourcei: procedure(source: TALuint; param: TALenum; value: PALint); cdecl;
  alListenerf: procedure(param: TALenum; value: TALfloat); cdecl;
  alSourcePlay: procedure(source: TALuint); cdecl;
  alSourcei: procedure(source: TALuint; param: TALenum; value: TALint); cdecl;
  alSourcef: procedure(source: TALuint; param: TALenum; value: TALfloat); cdecl;
  alSourcefv: procedure(source: TALuint; param: TALenum; values: PALfloat); cdecl;  
  alcCloseDevice: procedure(device: TALCdevice); cdecl;
  alcCreateContext: function(device: TALCdevice; attrlist: PALCint): TALCcontext; cdecl;
  alcDestroyContext: procedure(context: TALCcontext); cdecl;
  alcMakeContextCurrent: function(context: TALCcontext): TALCenum; cdecl;
  alcOpenDevice: function(deviceName: PALCuByte): TALCdevice; cdecl;

  alutInit: procedure(argc: PALint; argv: PPALbyte); cdecl;
  alutExit: procedure; cdecl;
  alutLoadWAVFile: procedure(fname: string; var format: TALenum; var data: TALvoid; var size: TALsizei; var freq: TALsizei; var loop: TALint); cdecl;
  alutLoadWAVMemory: procedure(memory: PALbyte; var format: TALenum; var data: TALvoid; var size: TALsizei; var freq: TALsizei; var loop: TALint); cdecl;
  alutUnloadWAV: procedure(format: TALenum; data: TALvoid; size: TALsizei; freq: TALsizei); cdecl;  

  alSourceQueueBuffers: procedure(source: TALuint; n: TALsizei; buffers: PALuint); cdecl;
  alSourceUnqueueBuffers: procedure(source: TALuint; n: TALsizei; buffers: PALuint); cdecl;

function InitOpenAL(LibName: String; AlutName: String = ''): Boolean;

implementation

var
  LibHandle          : THandle = 0;
  AlutHandle         : THandle = 0;

function alProcedure(ProcName : PChar) : Pointer;
begin
  Result := nil;
  if Addr(alGetProcAddress) <> nil then
    Result := alGetProcAddress(ProcName);
  if result <> NIL then
    Exit;
  Result := GetProcAddress(LibHandle, PAnsiChar(ProcName));
end;

function InitOpenAL;
begin
  Result       := False;
  //if LibHandle<>0 then FreeLibrary(LibHandle);
  LibHandle    := LoadLibrary(PAnsiChar(LibName));

  alGetProcAddress := GetProcAddress(LibHandle, 'alGetProcAddress');

  if (LibHandle <> 0) then
  begin

    alBufferData:= alProcedure('alBufferData');
    alDeleteBuffers:= alProcedure('alDeleteBuffers');
    alDeleteSources:= alProcedure('alDeleteSources');
    alGenBuffers:= alProcedure('alGenBuffers');
    alGenSources:= alProcedure('alGenSources');
    alGetError:= alProcedure('alGetError');
    alGetSourcei:= alProcedure('alGetSourcei');
    alListenerf:= alProcedure('alListenerf');
    alSourcePlay:= alProcedure('alSourcePlay');
    alSourcei:= alProcedure('alSourcei');
    alSourcef:= alProcedure('alSourcef');
    alSourcefv:= alProcedure('alSourcefv');
    alSourceQueueBuffers := alProcedure('alSourceQueueBuffers');
    alSourceUnqueueBuffers := alProcedure('alSourceUnqueueBuffers');
    alcCloseDevice:= alProcedure('alcCloseDevice');
    alcCreateContext:= alProcedure('alcCreateContext');
    alcDestroyContext:= alProcedure('alcDestroyContext');
    alcMakeContextCurrent:= alProcedure('alcMakeContextCurrent');
    alcOpenDevice:= alProcedure('alcOpenDevice');

    Result:=True;
  end;

  if AlutName <> '' then begin
    AlutHandle    := LoadLibrary(PAnsiChar(AlutName));
    if (AlutHandle <> 0) then
    begin
      alutInit:= GetProcAddress(AlutHandle, 'alutInit');
      alutExit:= GetProcAddress(AlutHandle, 'alutExit');
      alutLoadWAVFile:= GetProcAddress(AlutHandle, 'alutLoadWAVFile');
      alutLoadWAVMemory:= GetProcAddress(AlutHandle, 'alutLoadWAVMemory');
      alutUnloadWAV:= GetProcAddress(AlutHandle, 'alutUnloadWAV');
    end else
      Result := False;
  end;
end;

end.
