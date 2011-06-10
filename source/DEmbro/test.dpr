uses
  {$IFDEF FLAG_FPC}
    DMath in '..\DEngine\FPC\DMath.pas',
  {$ELSE}
    DMath in '..\DEngine\DELPHI\DMath.pas',
  {$ENDIF}

  DEncoding in '..\DLocal\DEncoding.pas',
  //DTranslater in '..\DLocal\DTranslater.pas',

  //DXML in '..\DParser\DXML.pas',
  //DXMLExecutor in '..\DParser\DXMLExecutor.pas',
  DIni in '..\DParser\DIni.pas',
  DTreeExpr in '..\DParser\DTreeExpr.pas',

  {$IFNDEF FLAG_DEBUG}
    winsock in '..\DEngine\WINSOCK\winsock.pas',
  {$ENDIF}

  DEvents in '..\DEngine\DEvents.pas',
  DClasses in '..\DEngine\DClasses.pas',
  DWinApi in '..\DEngine\WINDOWS\DWinApi.pas',
  DNet in '..\DEngine\WINSOCK\DNet.pas',
  DLib in '..\DEngine\WINDOWS\DLib.pas',

  DUtils in '..\DEngine\DUtils.pas',
  DDebug in '..\DEngine\DDebug.pas',
  DParser in '..\DEngine\DParser.pas',

  DMachineCode in '..\DMachineCode\DMachineCode.pas',
  Dx86 in '..\DMachineCode\Dx86.pas',

  DEmbroCore,
  DEmbroSpace,
  DEmbroManager,
  DMemMeta,
  DEmbroSource,

  DCommandsBool in 'commands\DCommandsBool.pas',
  DCommandsMisc in 'commands\DCommandsMisc.pas',
  DCommandsArithmetic in 'commands\DCommandsArithmetic.pas',
  DCommandsSignedArithmetic in 'commands\DCommandsSignedArithmetic.pas',
  DCommandsNumberArithmetic in 'commands\DCommandsNumberArithmetic.pas',
  DCommandsConvertNumber in 'commands\DCommandsConvertNumber.pas',
  DCommandsConsole in 'commands\DCommandsConsole',
  DCommandsStrings in 'commands\DCommandsStrings',
  DCommandsAlien in 'commands\DCommandsAlien',
  DCommandsF in 'commands\DCommandsF',
  DCommandsBW in 'commands\DCommandsBW',
  DCommandsCompile in 'commands\DCommandsCompile',
  DCommandsCreatewords in 'commands\DCommandsCreatewords',
  DCommandsFiles in 'commands\DCommandsFiles',
  DCommandsInt in 'commands\DCommandsInt',
  DCommandsMem in 'commands\DCommandsMem',
  DCommandsOS in 'commands\DCommandsOS',
  DCommandsPtr in 'commands\DCommandsPtr',
  DCommandsR in 'commands\DCommandsR',
  DCommandsSource in 'commands\DCommandsSource',
  DCommandsVM in 'commands\DCommandsVM',
  DCommandsVoc in 'commands\DCommandsVoc',
  DCommandsExtInt in 'commands\DCommandsExtInt',
  DCommandsEmbro in 'commands\DCommandsEmbro.pas',
  DCommandsControl in 'commands\DCommandsControl.pas',

  DAlien,
  //DForthStack,
  DForthMachine,
  DVocabulary,
  DExecutable,
  DCommandLine,
  DPlugin,
  DCompiler;

const
  TEST_LINE: PChar = '{ dup swap over 1 + // / source-next-name' + #10#13 +
                     '45 4.5f glOpen Такие дела, привет }';
var
  I: Integer;
  Source: PSource;

begin
  Source := New(PSourcePChar, 
        Create(
                New(PCommonNameReader, Create),
                New(PSimpleSpaceSkipper, Create),
                New(PWindowsLineReader, Create),
                TEST_LINE
              ));
  Writeln('Source created');
  while not Source.EOS do
    Write(Source^.NextChar);
  Writeln;
  Dispose(Source);

  Source := New(PSourcePChar, 
        Create(
                New(PCommonNameReader, Create),
                New(PSimpleSpaceSkipper, Create),
                New(PWindowsLineReader, Create),
                TEST_LINE
              ));
  while not Source.EOS do
    Writeln(Source.NextName);
  Dispose(Source);
end.
