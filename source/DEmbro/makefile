.PHONY: all
.PHONY: pas4
.PHONY: release
.PHONY: doc
.PHONY: dll
.PHONY: DMachineCode
.PHONY: Dx86
.PHONY: DArm
.PHONY: asm

all: clean pas4 pasq
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"..\..\release\" -FUtemp
#	fpc dforth32.dpr -dFLAG_FPC -Sd
#	fpc example.dpr -dFLAG_FPC -Sd

test: clean pas4 pasq
	fpc -vb test.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FEtemp -FUtemp

pas4:
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.temp4
	m4 id2.m4 DForthMachine.temp4 > DForthMachine.pas 
	m4 DEmbroSpace.pas4 > DEmbroSpace.pas
	m4 DEmbroCore.pas4 > DEmbroCore.pas
	m4 DEmbroManager.pas4 > DEmbroManager.pas
	m4 DMemMeta.pas4 > DMemMeta.pas
	m4 ..\m4\metapascal.m4 DEmbroSource.pas4 > DEmbroSource.pasq
	m4 commands.m4 commands\DCommandsAlien.pas4 > commands\DCommandsAlien.pasq
	m4 commands.m4 commands\DCommandsBool.pas4 > commands\DCommandsBool.pasq
	m4 commands.m4 commands\DCommandsBW.pas4 > commands\DCommandsBW.pasq
	m4 commands.m4 commands\DCommandsCompile.pas4 > commands\DCommandsCompile.pasq
	m4 commands.m4 commands\DCommandsConsole.pas4 > commands\DCommandsConsole.pasq
	m4 commands.m4 commands\DCommandsCreatewords.pas4 > commands\DCommandsCreatewords.pasq
	m4 commands.m4 commands\DCommandsEmbro.pas4 > commands\DCommandsEmbro.pasq
	m4 commands.m4 commands\DCommandsExtInt.pas4 > commands\DCommandsExtInt.pasq
	m4 commands.m4 commands\DCommandsF.pas4 > commands\DCommandsF.pasq
	m4 commands.m4 commands\DCommandsFiles.pas4 > commands\DCommandsFiles.pasq
	m4 commands.m4 commands\DCommandsInt.pas4 > commands\DCommandsInt.temp
	m4 id2.m4 commands\DCommandsInt.temp > commands\DCommandsInt.pasq
	m4 commands.m4 commands\DCommandsMem.pas4 > commands\DCommandsMem.pasq
	m4 commands.m4 commands\DCommandsMisc.pas4 > commands\DCommandsMisc.pasq
	m4 commands.m4 commands\DCommandsOS.pas4 > commands\DCommandsOS.pasq
	m4 commands.m4 commands\DCommandsPtr.pas4 > commands\DCommandsPtr.pasq
	m4 commands.m4 commands\DCommandsR.pas4 > commands\DCommandsR.pasq
	m4 commands.m4 commands\DCommandsSource.pas4 > commands\DCommandsSource.pasq
	m4 commands.m4 commands\DCommandsStrings.pas4 > commands\DCommandsStrings.pasq
	m4 commands.m4 commands\DCommandsVM.pas4 > commands\DCommandsVM.pasq
	m4 commands.m4 commands\DCommandsVoc.pas4 > commands\DCommandsVoc.pasq
	m4 commands.m4 commands\DCommandsArithmetic.pas4 > commands\DCommandsArithmetic.pasq
	m4 commands.m4 commands\DCommandsSignedArithmetic.pas4 > commands\DCommandsSignedArithmetic.pasq
	m4 commands.m4 commands\DCommandsNumberArithmetic.pas4 > commands\DCommandsNumberArithmetic.temp
	m4 id2.m4 commands\DCommandsNumberArithmetic.temp > commands\DCommandsNumberArithmetic.pasq
	m4 commands.m4 commands\DCommandsConvertNumber.pas4 > commands\DCommandsConvertNumber.temp
	m4 id2.m4 commands\DCommandsConvertNumber.temp > commands\DCommandsConvertNumber.pasq
	m4 commands\DCommandsControl.pas4 > commands\DCommandsControl.pasq

pasq:
	dquotes -r .\ *.pasq *.pas

DMachineCode: Dx86 DArm

Dx86:
	m4 ..\DMachineCode\Dx86.pas4 > ..\DMachineCode\Dx86.temp1
	m4 ..\m4\hex.m4 ..\DMachineCode\Dx86.temp1 > ..\DMachineCode\Dx86.pas

DArm:
	m4 ..\DMachineCode\DArm.pas4 > ..\DMachineCode\DArm.temp1
	m4 ..\m4\hex.m4 ..\DMachineCode\DArm.temp1 > ..\DMachineCode\DArm.pas

dll:
	fpc dembro32lib.dpr -dFLAG_FPC -Sd -O3 -al -an -ar -at -gl -FE..\..\release\ -FU.\temp

release: clean
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -FE ..\..\release\ -FU .\temp
	fpc dembro32lib.dpr -dFLAG_FPC -dFLAG_NOLOG -Sd -O3 -FE..\..\release\ -FU .\temp
	upx ..\..\release\dembro32.exe
	upx ..\..\release\dembro32lib.dll

doc:
	m4 ..\m4\googlecode.m4 DForthMachine.pas4 > ..\..\wiki\DForthMachine
	cd ..\..\wiki & dcut -m _DOC_CUT_ -s DForthMachine

clean:
	del temp\* /Q
	del *.o /Q
	del *.ppu /Q

asm: clean
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -Sd -O3 -Anasmobj -al -an -ar -at -gl -FE..\..\release\ -FU.\temp
