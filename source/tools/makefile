.PHONY: all
.PHONY: debug

UPX = echo

all: dquotes.exe drecursive.exe dtime.exe

dquotes.exe: dquotes.dpr utils.pas
	fpc dquotes.dpr -dFLAG_FPC -Sd
	$(UPX) dquotes

drecursive.exe: drecursive.dpr utils.pas
	fpc drecursive.dpr -dFLAG_FPC -Sd
	$(UPX) drecursive

dtime.exe: dtime.dpr
	fpc dtime.dpr -dFLAG_FPC -Sd
	$(UPX) dtime
	
debug:
	fpc testcmdline.dpr -gl -dFLAG_FPC -Sd
