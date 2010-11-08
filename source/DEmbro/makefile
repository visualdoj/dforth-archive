.PHONY: all
.PHONY: release
.PHONY: doc
.PHONY: dll
.PHONY: DMachineCode

all: clean DMachineCode
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -Sd -O3 -al -an -ar -at -gl -FE..\..\release\ -FU.\temp
#	fpc dforth32.dpr -dFLAG_FPC -Sd
#	fpc example.dpr -dFLAG_FPC -Sd

DMachineCode:
	m4 ..\DMachineCode\Dx86.pas4 > ..\DMachineCode\Dx86.temp1
	m4 ..\m4\hex.m4 ..\DMachineCode\Dx86.temp1 > ..\DMachineCode\Dx86.pas
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
