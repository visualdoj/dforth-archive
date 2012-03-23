unit DLib;

interface

uses
  {$IFDEF WIN32}windows{$ENDIF}
  {$IFDEF UNIX}unix, BaseUnix{$ENDIF};

type
TLib = class
 private
  FHandle: Integer;
  function GetReady: Boolean;
 public
  constructor Create(FileName: PChar);
  destructor Destroy; override;
  function GetProcAddress(Name: PChar): Pointer;
  property Ready: Boolean read GetReady;
end;

implementation

{$IFDEF UNIX}
function dlopen(name: pchar; mode: longint): pointer; cdecl; external 'dl';
function dlsym(lib: pointer; name: pchar): pointer; cdecl; external 'dl';
function dlclose(lib: pointer): longint; cdecl; external 'dl';
{$ENDIF}

function TLib.GetReady: Boolean;
begin
  Result := FHandle <> 0;
end;

constructor TLib.Create(FileName: PChar);
begin
  {$IFDEF WIN32}
  FHandle := LoadLibrary(FileName);
  {$ENDIF}
  {$IFDEF UNIX}
  Writeln('Openning ', FileName);
  FHandle := PtrInt(dlopen(FileName, 1 {RTLD_LAZY??}));
  {$ENDIF}
end;

destructor TLib.Destroy;
begin
  {$IFDEF WIN32}
  FreeLibrary(FHandle);
  {$ENDIF}
  {$IFDEF UNIX}
  dlclose(Pointer(FHandle));
  {$ENDIF}
end;

function TLib.GetProcAddress(Name: PChar): Pointer;
begin
  {$IFDEF WIN32}
  Result := windows.GetProcAddress(FHandle, Name);
  {$ENDIF}
  {$IFDEF UNIX}
  Result := dlsym(Pointer(FHandle), Name);
  {$ENDIF}
end;

end.
