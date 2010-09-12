unit DLib;

interface

uses
  windows;

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
  FHandle := LoadLibrary(FileName);
end;

destructor TLib.Destroy;
begin
  FreeLibrary(FHandle);
end;

function TLib.GetProcAddress(Name: PChar): Pointer;
begin
  Result := windows.GetProcAddress(FHandle, Name);
end;

end.
