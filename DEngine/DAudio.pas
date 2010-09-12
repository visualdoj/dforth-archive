unit DAudio;

interface

uses
  DUtils;

type
TMusicPlayer = class;
TMusicFormat = class;
TListOfMusicFormat = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TMusicFormat>;
CMusicFormat = class of TMusicFormat;
TListOfCMusicFormat = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<CMusicFormat>;
TMusic = class;
TSampleFormat = class;
TListOfSampleFormat = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TSampleFormat>;
CSampleFormat = class of TSampleFormat;
TListOfCSampleFormat = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<CSampleFormat>;
TSample = class;
TAudioFormats = class;
TAudio = class;

{$IFNDEF FLAG_FPC}{$REGION 'TMusicPlayer'}{$ENDIF}
// Наследники этого класса должны обрабатывать все музыкальные действия
TMusicPlayer = class
 public
  // только загрузка
  function OnLoad(const FileName: TString): Boolean; virtual;
  // начать проигрывание, если было на паузе, то начать с предыдущей позиции
  procedure OnPlay; virtual;
  // остановить воспроизведение, сбросить позицию
  procedure OnStop; virtual;
  //
  procedure OnPause; virtual;
  // апдейт, предполагать, что вызывается не режк одного раза в секунду
  procedure OnUpdate; virtual;
  // громкость: 0 - полная тишина, 1 - максимальная громкость
  procedure SetVolume(Volume: Single); virtual;
  function GetVolume: Single; virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TMusicFormat'}{$ENDIF}
// класс-фабрика для музыки
TMusicFormat = class
 private
  FAudio: TAudio;
 protected
  procedure DoCreate; virtual;
 public
  constructor Create(Audio: TAudio);
  // вернуть nil, если загрузить не удалось
  function Load(const FileName: TString): TMusicPlayer; virtual;
  //
  property Audio: TAudio read FAudio;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TMusic'}{$ENDIF}
// класс-обертка над плеером
TMusic = class
 private
  FAudio: TAudio;
  FPlayer: TMusicPlayer;
  FFileName: TString;
 protected
  function GetVolume: Single;
  procedure SetVolume(Volume: Single);
  procedure Update;
 public
  constructor Create(Audio: TAudio);
  destructor Destroy; override;
  procedure Play(const FileName: TString);
  procedure Stop;
  procedure Pause;
  property Volume: Single read GetVolume write SetVolume;
  property Audio: TAudio read FAudio;
  property FileName: TString read FFileName;
  property Player: TMusicPlayer read FPlayer;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSampleFormat'}{$ENDIF}
// фабрика для создания сэмпла
TSampleFormat = class
 private
  FAudio: TAudio;
 protected
  procedure DoCreate; virtual;
 public
  constructor Create(Audio: TAudio);
  function Load(const FileName: TString): TSample;
  property Audio: TAudio read FAudio;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSample'}{$ENDIF}
TSample = class
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TAudioFormats'}{$ENDIF}
TAudioFormats = class
 private
  FMusicFormats: TListOfCMusicFormat;
  FSampleFormats: TListOfCSampleFormat;
 public
  constructor Create;
  destructor Destroy; override;
  procedure RegistMusicFormat(MusicFormat: CMusicFormat);
  procedure RegistSampleFormat(SampleFormat: CSampleFormat);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TAudio'}{$ENDIF}
TAudio = class
 private
  FMusic: TMusic;
  FMusicFormats: TListOfMusicFormat;
  FSampleFormats: TListOfSampleFormat;
 public
  constructor Create;
  destructor Destroy; override;
  procedure Update;
  // загружает сэмпл
  // удаления сэмпла происходит просто вызовом Free у него
  function LoadSample(const FileName: TString): TSample;
  // в отличие от предыдущего, автоматически удалит сэмпл как только 
  // он прекратит проигрывание  
  function PlaySample(const FileName: TString): TSample;
  // доступ к музыке
  property Music: TMusic read FMusic;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

var
  AudioFormats: TAudioFormats;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TMusicPlayer'}{$ENDIF}
function TMusicPlayer.OnLoad;
begin
  Result := False;
end;

procedure TMusicPlayer.OnPlay;
begin
end;

procedure TMusicPlayer.OnStop;
begin
end;

procedure TMusicPlayer.OnPause;
begin
end;

procedure TMusicPlayer.OnUpdate;
begin
end;

procedure TMusicPlayer.SetVolume(Volume: Single); 
begin
end;

function TMusicPlayer.GetVolume: Single;
begin
  Result := 0;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TMusicFormat'}{$ENDIF}
procedure TMusicFormat.DoCreate; 
begin
end;

constructor TMusicFormat.Create(Audio: TAudio);
begin
  FAudio := Audio;
  DoCreate;
end;

function TMusicFormat.Load(const FileName: TString): TMusicPlayer;
begin
  Result := nil;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TMusic'}{$ENDIF}
function TMusic.GetVolume: Single;
begin
  if FPlayer <> nil then
    Result := FPlayer.GetVolume
  else
    Result := 0;
end;

procedure TMusic.SetVolume(Volume: Single);
begin
  if FPlayer <> nil then
    FPlayer.SetVolume(Volume);
end;

procedure TMusic.Update;
begin
  if FPlayer <> nil then
    FPlayer.OnUpdate;
end;

constructor TMusic.Create(Audio: TAudio);
begin
  FAudio := Audio;
  FPlayer := nil;
end;

destructor TMusic.Destroy;
begin
  if FPlayer <> nil then
    FPlayer.Free;
end;

procedure TMusic.Play(const FileName: TString);
  var
    I: Integer;
begin
  if FPlayer <> nil then 
    FPlayer.Free;
  
  // TODO: что-то более структурированное
  for I := 0 to Audio.FMusicFormats.Count - 1 do begin
    FPlayer := Audio.FMusicFormats[I].Load(FileName);
    if FPlayer.OnLoad(FileName) then begin
      FPlayer.OnPlay;
      Break;
    end;
    FPlayer.Free;
    FPlayer := nil;
  end;
end;

procedure TMusic.Stop;
begin
  if FPlayer <> nil then
    FPlayer.OnStop;
end;

procedure TMusic.Pause;
begin
  if FPlayer <> nil then
    FPlayer.OnPause;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TSampleFormat'}{$ENDIF}
procedure TSampleFormat.DoCreate;
begin
end;

function TSampleFormat.Load(const FileName: TString): TSample;
begin
  Result := nil;
end;

constructor TSampleFormat.Create(Audio: TAudio);
begin
  FAudio := Audio;
  DoCreate;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TAudioFormats'}{$ENDIF}
constructor TAudioFormats.Create;
begin
  FMusicFormats := TListOfCMusicFormat.Create;
  FSampleFormats := TListOfCSampleFormat.Create;
end;

destructor TAudioFormats.Destroy;
begin
  FSampleFormats.Free;
  FMusicFormats.Free;
end;

procedure TAudioFormats.RegistMusicFormat(MusicFormat: CMusicFormat);
begin
  FMusicFormats.Add(MusicFormat);
end;

procedure TAudioFormats.RegistSampleFormat(SampleFormat: CSampleFormat);
begin
  FSampleFormats.Add(SampleFormat);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TAudio'}{$ENDIF}
constructor TAudio.Create;
  var
    I: Integer;
begin
  FMusicFormats := TListOfMusicFormat.Create;
  FMusicFormats.Count := AudioFormats.FMusicFormats.Count;
  for I := 0 to FMusicFormats.Count - 1 do
    FMusicFormats[I] := AudioFormats.FMusicFormats[I].Create(Self);
    
  FSampleFormats := TListOfSampleFormat.Create;
  FSampleFormats.Count := AudioFormats.FSampleFormats.Count;
  for I := 0 to FSampleFormats.Count - 1 do
    FSampleFormats[I] := AudioFormats.FSampleFormats[I].Create(Self);

  FMusic := TMusic.Create(Self);
end;

destructor TAudio.Destroy;
  var
    I: Integer;
begin
  FMusic.Free;
  for I := 0 to FMusicFormats.Count - 1 do
    FMusicFormats[I].Free;
  FMusicFormats.Free;
  for I := 0 to FSampleFormats.Count - 1 do
    FSampleFormats[I].Free;
  FSampleFormats.Free;
end;

procedure TAudio.Update;
begin
  FMusic.Update;
end;

function TAudio.LoadSample(const FileName: TString): TSample;
  var
    I: Integer;
begin
  Result := nil;
  for I := 0 to FSampleFormats.Count - 1 do begin
    Result := FSampleFormats[I].Load(FileName);
    if Result <> nil then
      Break;
  end;
end;

function TAudio.PlaySample(const FileName: TString): TSample;
begin
  Result := LoadSample(FileName);
  if Result <> nil then begin
    //Result.Play;
    // TODO: поставить на учет в удаление
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  AudioFormats := TAudioFormats.Create;
finalization
  AudioFormats.Free;
end.
