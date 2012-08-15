{$I platform.inc}
unit DLib;

interface

uses
  {$IFDEF WIN32}windows{$ENDIF}
  {$IFDEF LINUX_or_BSD}DynLibs, unix, BaseUnix, dl{$ENDIF};

type
TLib = class
 private
  {$IFDEF WIN32}
  FHandle: Integer;
  {$ENDIF}
  {$IFDEF LINUX_or_BSD}
  FHandle: TLibHandle;
  {$ENDIF}
  function GetReady: Boolean;
 public
  constructor Create(FileName: PChar);
  destructor Destroy; override;
  function GetProcAddress(Name: PChar): Pointer;
  property Ready: Boolean read GetReady;
end;

implementation

{$IFDEF LINUX_or_BSD}
//function dlopen(name: pchar; mode: longint): pointer; cdecl; external 'dl';
//function dlsym(lib: pointer; name: pchar): pointer; cdecl; external 'dl';
//function dlclose(lib: pointer): longint; cdecl; external 'dl';
{$ENDIF}

function TLib.GetReady: Boolean;
begin
  {$IFDEF WIN32}
  Result := FHandle <> 0;
  {$ENDIF}
  {$IFDEF LINUX_or_BSD}
  Result := FHandle <> NilHandle;
  {$ENDIF}
end;

constructor TLib.Create(FileName: PChar);
begin
  {$IFDEF WIN32}
  FHandle := LoadLibrary(FileName);
  {$ENDIF}
  {$IFDEF LINUX_or_BSD}
  Writeln('Openning ', FileName);
  //FHandle := PtrInt(dlopen(FileName, 1 {RTLD_LAZY??}));
  FHandle := LoadLibrary(FileName);
  {$ENDIF}
end;

destructor TLib.Destroy;
begin
  {$IFDEF WIN32}
  FreeLibrary(FHandle);
  {$ENDIF}
  {$IFDEF LINUX_or_BSD}
  //dlclose(Pointer(FHandle));
  FreeLibrary(FHandle);
  {$ENDIF}
end;

function TLib.GetProcAddress(Name: PChar): Pointer;
begin
  {$IFDEF WIN32}
  Result := windows.GetProcAddress(FHandle, Name);
  {$ENDIF}
  {$IFDEF LINUX_or_BSD}
  //Result := dlsym(Pointer(FHandle), Name);
  Result := GetProcedureAddress(FHandle, Name);
  {$ENDIF}
end;

end.
