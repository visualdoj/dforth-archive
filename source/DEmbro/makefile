.PHONY: all
.PHONY: release
.PHONY: doc
.PHONY: dll
.PHONY: DMachineCode
.PHONY: Dx86
.PHONY: DArm
.PHONY: asm

all: clean
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.temp4
	m4 id2.m4 DForthMachine.temp4 > DForthMachine.pas 
	m4 DEmbroSpace.pas4 > DEmbroSpace.pas
	m4 DEmbroCore.pas4 > DEmbroCore.pas
	m4 DEmbroManager.pas4 > DEmbroManager.pas
	m4 commands\DCommandsStrings.pas4 > commands\DCommandsStrings.pas
	m4 commands\DCommandsFiles.pas4 > commands\DCommandsFiles.pas
	m4 commands\DCommandsOS.pas4 > commands\DCommandsOS.pas
	m4 commands\DCommandsF.pas4 > commands\DCommandsF.pas
	m4 commands\DCommandsVM.pas4 > commands\DCommandsVM.pas
	m4 commands\DCommandsMisc.pas4 > commands\DCommandsMisc.pas
	m4 commands\DCommandsBW.pas4 > commands\DCommandsBW.pas
	m4 commands\DCommandsInt.pas4 > commands\DCommandsInt.pas
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE..\..\release\ -FU.\temp
#	fpc dforth32.dpr -dFLAG_FPC -Sd
#	fpc example.dpr -dFLAG_FPC -Sd

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
	fpc dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -FE..\..\release\ -FU.\temp
	fpc dembro32lib.dpr -dFLAG_FPC -dFLAG_NOLOG -Sd -O3 -FE..\..\release\ -FU.\temp
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
