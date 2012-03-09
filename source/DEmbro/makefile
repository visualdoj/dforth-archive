.PHONY: all
.PHONY: pas4
.PHONY: release
.PHONY: doc
.PHONY: dll
.PHONY: DMachineCode
.PHONY: Dx86
.PHONY: DArm
.PHONY: asm
.PHONY: commands
.PHONY: compile
.PHONY: copy

ifeq ($(OS),Windows_NT)
  RM := del /Q
  CHMOD := echo
  CAT := type
  S := \\
else
  RM := rm -f
  CHMOD := chmod
  CAT := cat
  S := /
endif

SOURCE_PATHS = *.ext \
               ../DEngine/*.ext \
               ../DEngine/WINDOWS/*.ext \
               ../DEngine/WINDOWS/*.ext \
               ../DEngine/WINSOCK/*.ext \
               ../DEngine/OPENGL/*.ext \
               ../DEngine/OPENAL/*.ext \
               ../DEngine/FPC/*.ext \
               ../DLocal/*.ext \
               ../DMachineCode/*.ext

# SOURCES_PAS4 := $(wildcard *.pas4) \
#                 $(wildcard ../DEngine/*.pas4) \
#                 $(wildcard ../DEngine/WINDOWS/*.pas4) \
#                 $(wildcard ../DEngine/WINDOWS/*.pas4) \
#                 $(wildcard ../DEngine/WINSOCK/*.pas4) \
#                 $(wildcard ../DEngine/OPENGL/*.pas4) \
#                 $(wildcard ../DEngine/OPENAL/*.pas4) \
#                 $(wildcard ../DEngine/FPC/*.pas4) \
#                 $(wildcard ../DLocal/*.pas4) \
#                 $(wildcard ../DMachineCode/*.pas4)

SOURCES_PAS4 := $(wildcard $(SOURCE_PATHS:%.ext=%.pas4))
SOURCES_PAS := $(wildcard $(SOURCE_PATHS:%.ext=%.pas))
# SOURCES_PAS := $(@:%.pas4=%.pas)
SOURCES := $(SOURCES_PAS4)

BASE_LIST := $(addprefix temp/,$(basename $(notdir $(SOURCES_PAS4))))
PAS_LIST := $(addsuffix .pas,$(BASE_LIST))
PASQ_LIST := $(addsuffix .pasq,$(BASE_LIST))
PASTEMP_LIST := $(addsuffix .pastemp,$(BASE_LIST))
PAS4COPY_LIST := $(addsuffix .pas4.copy,$(BASE_LIST))
PAS4_LIST := $(addsuffix .pas4,$(BASE_LIST))

DQUOTES = ../tools/dquotes

compile: ../../release/dembro32.exe;

all: clean pas4 pasq
	$(DQUOTES) -r .\ *.pasq *.pas
	$(DQUOTES) commands\DCommandsMisc.pasq commands\DCommandsMisc.pas
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"..\..\release\" -FUtemp
#	fpc dforth32.dpr -dFLAG_FPC -Sd
#	fpc example.dpr -dFLAG_FPC -Sd

# test: clean pas4 pasq
# 	fpc -vb test.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FEtemp -FUtemp

sources:
	echo $(wildcard $(SOURCES))
#	echo $(SOURCES)

pas4:
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.temp4
	m4 id2.m4 DForthMachine.temp4 > DForthMachine.pas 
	m4 meta.m4 console.pas4 > temp\console.temp4
	m4 id2.m4 temp\console.temp4 > console.pas
	m4 meta.m4 sh.pas4 > temp\sh.temp4
	m4 id2.m4 temp\sh.temp4 > sh.pas
	m4 meta.m4 pool.pas4 > temp\pool.temp4
	m4 id2.m4 temp\pool.temp4 > pool.pas
	m4 ..\m4\id.m4 stream.pas4 > temp\stream.temp4
	m4 id2.m4 temp\stream.temp4 > stream.pas
	m4 DEmbroSpace.pas4 > DEmbroSpace.pas
	m4 DEmbroCore.pas4 > DEmbroCore.pas
	m4 DEmbroManager.pas4 > DEmbroManager.pas
	m4 DMemMeta.pas4 > DMemMeta.pas
	m4 ..\m4\metapascal.m4 DEmbroSource.pas4 > DEmbroSource.pasq
	m4 ..\m4\metapascal.m4 DEmbroChunk.pas4 > DEmbroChunk.pasq
	m4 commands.m4 commands\DCommandsAlien.pas4 > commands\DCommandsAlien.pasq
	m4 commands.m4 commands\DCommandsConsole.pas4 > commands\DCommandsConsole.pasq
	m4 commands.m4 commands\DCommandsMisc.pas4 > commands\DCommandsMisc.pasq
	m4 commands.m4 commands\DCommandsStrings.pas4 > commands\DCommandsStrings.pasq
	m4 commands.m4 commands\DCommandsVoc.pas4 > commands\DCommandsVoc.pasq
	m4 commands.m4 commands\DCommandsNumberArithmetic.pas4 > commands\DCommandsNumberArithmetic.temp
	m4 id2.m4 commands\DCommandsNumberArithmetic.temp > commands\DCommandsNumberArithmetic.pasq
	m4 commands\DCommandsControl.pas4 > commands\DCommandsControl.pasq
	m4 DCommandsTable.pas4 > DCommandsTable.pasq
	$(DQUOTES) -r .\ *.pasq *.pas

pasq:
	$(DQUOTES) -r .\ *.pasq *.pas

DMachineCode: Dx86 DArm

Dx86:
	m4 ..\DMachineCode\Dx86.pas4 > ..\DMachineCode\Dx86.temp1
	m4 ..\m4\hex.m4 ..\DMachineCode\Dx86.temp1 > ..\DMachineCode\Dx86.pas

DArm:
	m4 ..\DMachineCode\DArm.pas4 > ..\DMachineCode\DArm.temp1
	m4 ..\m4\hex.m4 ..\DMachineCode\DArm.temp1 > ..\DMachineCode\DArm.pas

dll:
	fpc dembro32lib.dpr -dFLAG_FPC -Sd -O3 -al -an -ar -at -gl -FE..\..\release\ -FU.\temp

release: clean pas4 pasq
	fpc dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -FE"..\..\release\" -FU".\temp"
#	fpc dembro32lib.dpr -dFLAG_FPC -dFLAG_NOLOG -Sd -O3 -FE"..\..\release\" -FU".\temp"
	upx ..\..\release\dembro32.exe
#	upx ..\..\release\dembro32lib.dll

doc:
	m4 ..\m4\googlecode.m4 DForthMachine.pas4 > ..\..\wiki\DForthMachine
	cd ..\..\wiki & dcut -m _DOC_CUT_ -s DForthMachine

clean:
	$(RM) temp$(S)*
	$(RM) *.o
	$(RM) *.ppu

asm: clean
	m4 ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	fpc -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -Sd -O3 -Anasmobj -al -an -ar -at -gl -FE..\..\release\ -FU.\temp

commands:
	$(RM) ../../release/core/builtin/*.de || echo skipped
	m4 ../m4/ctype.m4 commands/groups.list > temp/make_all.bat
	$(CHMOD) 744 temp/make_all.bat
	temp$(S)make_all.bat
#	$(CAT) commands/mem.cmd commands/misc.cmd > temp/all.cmd
	m4 ../m4/cgroups.m4 commands/groups.list > temp/all.cmd
	m4 ../m4/cload.m4 temp/all.cmd > temp/load.inc4
	m4 commands.m4 temp/load.inc4 > temp/load.temp
	m4 id2.m4 temp/load.temp > temp/load.incq
	$(DQUOTES) temp/load.incq load.inc
	m4 ../m4/cbody.m4 temp/all.cmd > temp/body.temp
	m4 id2.m4 temp/body.temp > temp/body.inc4
	m4 commands.m4 temp/body.inc4 > temp/body.incq
	$(DQUOTES) temp/body.incq body.inc
	m4 ../m4/g_builtin.m4 commands/groups.list > temp/make_builtin.bat
	$(CHMOD) 744 temp/make_builtin.bat
	temp$(S)make_builtin.bat
	m4 ../m4/g_help.m4 commands/groups.list > temp/make_docs.bat
	$(CHMOD) 744 temp/make_docs.bat
	temp$(S)make_docs.bat
	m4 ../m4/cevaluate.m4 commands/groups.list > ../../release/core/builtin/all.de
	m4 ../m4/c_rusall.m4 commands/groups.list > ../../release/docs/rus/all.de

copy: $(SOURCES)
	cp $(SOURCES) temp

# %.pas4.copy: copy
# 	cp $(@:%.pas4.copy=%.pas4) temp

%.pastemp: copy
	m4 meta.m4 $(@:%.pastemp=%.pas4) > $@

%.pasq: $(PASTEMP_LIST)
	m4 id2.m4 $(@:%.pasq=%.pastemp) > $@

%.pas: $(PASQ_LIST)
	$(DQUOTES) $(@:%.pas=%.pasq) $@

../../release/dembro32.exe: $(PAS_LIST)
	cp dembro32.dpr temp/dembro32.dpr
	cp *.inc temp
	fpc -vb temp/dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"../../release/" -FUtemp
