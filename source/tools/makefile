.PHONY: all

all: dquotes.exe drecursive.exe

dquotes.exe: dquotes.dpr utils.pas
	fpc dquotes.dpr -dFLAG_FPC -Sd
	upx dquotes.exe

drecursive.exe: drecursive.dpr utils.pas
	fpc drecursive.dpr -dFLAG_FPC -Sd
	upx drecursive.exe
	
