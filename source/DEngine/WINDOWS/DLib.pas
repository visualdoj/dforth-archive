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
  FHandle := 0;
  {$ENDIF}
end;

destructor TLib.Destroy;
begin
  {$IFDEF WIN32}
  FreeLibrary(FHandle);
  {$ENDIF}
  {$IFDEF UNIX}
  FHandle := 0;
  {$ENDIF}
end;

function TLib.GetProcAddress(Name: PChar): Pointer;
begin
  {$IFDEF WIN32}
  Result := windows.GetProcAddress(FHandle, Name);
  {$ENDIF}
  {$IFDEF UNIX}
  FHandle := 0;
  {$ENDIF}
end;

end.
