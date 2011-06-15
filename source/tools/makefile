.PHONY: all
.PHONY: debug

all: dquotes.exe drecursive.exe dtime.exe

dquotes.exe: dquotes.dpr utils.pas
	fpc dquotes.dpr -dFLAG_FPC -Sd
	upx dquotes.exe

drecursive.exe: drecursive.dpr utils.pas
	fpc drecursive.dpr -dFLAG_FPC -Sd
	upx drecursive.exe

dtime.exe: dtime.dpr
	fpc dtime.dpr -dFLAG_FPC -Sd
	upx dtime.exe
	
debug:
	fpc testcmdline.dpr -gl -dFLAG_FPC -Sd
