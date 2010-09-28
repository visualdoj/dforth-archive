.PHONY: all
.PHONY: release
.PHONY: doc

all:
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc -vb dforth.dpr -dFLAG_FPC -Sd -O3 -al -an -ar -at -gl -FE..\release\ -FU.\temp
#	fpc dforth32.dpr -dFLAG_FPC -Sd
#	fpc example.dpr -dFLAG_FPC -Sd

release:
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc dforth.dpr -dFLAG_FPC -Sd -FE..\release\ -FU.\temp
	upx dforth.exe

doc:
	m4 ..\m4\googlecode.m4 DForthMachine.pas4 > ..\..\wiki\DForthMachine
	cd ..\..\wiki & dcut -m _DOC_CUT_ -s DForthMachine
