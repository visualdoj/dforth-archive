.PHONY: doc
.PHONY: lib
.PHONY: DMachineCode
.PHONY: Dx86
.PHONY: DArm
.PHONY: asm
.PHONY: commands
.PHONY: compile
.PHONY: copy
.PHONY: help
.PHONY: makepp

FPC := fpc

ifeq ($(OS),Windows_NT)
  RM = del /Q
  CHMOD = echo
  CAT = type
  S = \\
  LIBPREFIX =
  LIBEXT = .dll
  EXEEXT = .exe
  UPDATE = cp
  M4 = m4
else
  RM = rm -f
  CHMOD = chmod
  CAT = cat
  S = /
  LIBPREFIX = lib
  LIBEXT = .so
  EXEEXT =
  UPDATE = cp
  M4 = m4
endif

SOURCE_PATHS = *.ext \
	       commands/*.ext \
               ../DEngine/*.ext \
               ../DEngine/WINDOWS/*.ext \
               ../DEngine/WINSOCK/*.ext \
               ../DEngine/OPENGL/*.ext \
               ../DEngine/OPENAL/*.ext \
               ../DEngine/FPC/*.ext \
               ../DLocal/*.ext \
               ../DMachineCode/*.ext

SOURCE_PATHS_CMD = commands/*.ext

SOURCES_PAS4 := $(wildcard $(SOURCE_PATHS:%.ext=%.pas4))
SOURCES_PAS := $(wildcard $(SOURCE_PATHS:%.ext=%.pas))
SOURCES_PP := $(wildcard $(SOURCE_PATHS:%.ext=%.pp))
SOURCES_INC := $(wildcard $(SOURCE_PATHS:%.ext=%.inc))
SOURCES := $(SOURCES_PAS4) $(SOURCES_PAS)
SOURCES_CMD := $(wildcard $(SOURCE_PATHS_CMD:%.ext=%.cmd))

BUILD_DIR=../.release
# TODO release : BUILD_DIR= ../.release
# TODO debug   : BUILD_DIR= ../.debug
BUILD_DIRS = $(dir $(addprefix $(BUILD_DIR)/DEmbro/,$(SOURCE_PATHS)))
BUILD_PAS4 = $(wildcard $(SOURCE_PATHS:%.ext=$(BUILD_DIR)/%.pas4))
BUILD_PASTEMP = $(addprefix $(BUILD_DIR)/DEmbro/,$(SOURCES_PAS4:%.pas4=%.pastemp))
BUILD_PASTEMP = $(addprefix $(BUILD_DIR)/DEmbro/,$(SOURCES_PAS4:%.pas4=%.pasq))
BUILD_PP = $(addprefix $(BUILD_DIR)/DEmbro/,$(SOURCES_PAS4:%.pas4=%.pp))
BUILD_INC = $(addprefix $(BUILD_DIR)/DEmbro/,$(SOURCES_INC:%.pas4=%.pp))

BASE_LIST := $(addprefix temp/,$(basename $(notdir $(SOURCES_PAS4))))
PAS_LIST := $(addsuffix .pas,$(BASE_LIST))
PP_LIST := $(addsuffix .pp,$(BASE_LIST))
PASQ_LIST := $(addsuffix .pasq,$(BASE_LIST))
PASTEMP_LIST := $(addsuffix .pastemp,$(BASE_LIST))
PAS4COPY_LIST := $(addsuffix .pas4.copy,$(BASE_LIST))
PAS4_LIST := $(addsuffix .pas4,$(BASE_LIST))

DQUOTES = ../tools/dquotes

help:
	$(CAT) README

compile: ../../release/de$(EXEEXT);

clean:
	$(RM) temp$(S)*
	$(RM) -rf ../.build/*
	$(RM) -rf ../.debug/*
	$(RM) -rf ../.release/*

../.build/DEmbro/%.pp : %.pas4 $(BUILD_DIRS)
	$(M4) meta.m4 $< > $(@:%.pp=%.pastemp)
	$(M4) id2.m4 $(@:%.pp=%.pastemp) > $(@:%.pp=%.pasq)
	$(DQUOTES) $(@:%.pp=%.pasq) $@

../.release/DEmbro/%.pp : %.pas4 $(BUILD_DIRS)
	$(M4) meta.m4 $< > $(@:%.pp=%.pastemp)
	$(M4) id2.m4 $(@:%.pp=%.pastemp) > $(@:%.pp=%.pasq)
	$(DQUOTES) $(@:%.pp=%.pasq) $@

../.release/DEmbro/%.inc : %.inc $(BUILD_DIRS)
	cp $< $@

#$(BUILD_DIR)/%.inc: commands;

makepp: commands $(BUILD_PP) $(BUILD_INC) $(BUILD_DIRS);

release: makepp lib compile headers;

debug: makepp lib compile headers;

Dx86:
	$(M4) ..\DMachineCode\Dx86.pas4 > ..\DMachineCode\Dx86.temp1
	$(M4) ..\m4\hex.m4 ..\DMachineCode\Dx86.temp1 > ..\DMachineCode\Dx86.pas

DArm:
	$(M4) ..\DMachineCode\DArm.pas4 > ..\DMachineCode\DArm.temp1
	$(M4) ..\m4\hex.m4 ..\DMachineCode\DArm.temp1 > ..\DMachineCode\DArm.pas

doc:
	$(M4) ..\m4\googlecode.m4 DForthMachine.pas4 > ..\..\wiki\DForthMachine
	cd ..\..\wiki & dcut -m _DOC_CUT_ -s DForthMachine

asm: clean
	$(M4) ..\m4\id.m4 DForthMachine.pas4 > DForthMachine.pas
	$(FPC) -vb dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -Sd -O3 -Anasmobj -al -an -ar -at -gl -FE..\..\release\ -FU.\temp

# COMMANDS
commands: $(SOURCES_CMD)
	$(RM) ../../release/core/builtin/*.de || echo skipped
	$(M4) ../m4/ctype.m4 commands/groups.list > temp/make_all.bat
	$(CHMOD) 744 temp/make_all.bat
	temp$(S)make_all.bat
	$(M4) ../m4/cgroups.m4 commands/groups.list > temp/all.cmd
	$(M4) ../m4/cload.m4 temp/all.cmd > temp/load.inc4
	$(M4) commands.m4 temp/load.inc4 > temp/load.temp
	$(M4) id2.m4 temp/load.temp > temp/load.incq
	$(DQUOTES) temp/load.incq load.inc
	$(M4) ../m4/cbody.m4 temp/all.cmd > temp/body.temp
	$(M4) id2.m4 temp/body.temp > temp/body.inc4
	$(M4) commands.m4 temp/body.inc4 > temp/body.incq
	$(DQUOTES) temp/body.incq body.inc
	$(M4) ../m4/g_builtin.m4 commands/groups.list > temp/make_builtin.bat
	$(CHMOD) 744 temp/make_builtin.bat
	temp$(S)make_builtin.bat
	$(M4) ../m4/g_help.m4 commands/groups.list > temp/make_docs.bat
	$(CHMOD) 744 temp/make_docs.bat
	temp$(S)make_docs.bat
	$(M4) ../m4/cevaluate.m4 commands/groups.list > ../../release/core/builtin/all.de
	$(M4) ../m4/c_rusall.m4 commands/groups.list > ../../release/docs/rus/all.de

temp/copy.stamp: $(SOURCES)
	$(UPDATE) $(SOURCES) temp
	$(UPDATE) *.inc temp
	echo copied > $@

copy: temp/copy.stamp;

#%.pastemp: temp/copy.stamp $(PAS4_LIST)
#	$(M4) meta.m4 $(@:%.pastemp=%.pas4) > $@

%.pasq: $(PASTEMP_LIST)
	$(M4) id2.m4 $(@:%.pasq=%.pastemp) > $@

%.pp: $(PASQ_LIST)
	$(DQUOTES) $(@:%.pp=%.pasq) $@
	cp -f $@ $(@:%.pp=%.pas)

%/:
	mkdir -p $@

../../release/dembro32: $(PP_LIST) dembro32.dpr $(BUILD_DIR)/DEmbro/body.inc
	cp dembro32.dpr temp/dembro32.dpr
	cp *.inc temp
	$(FPC) -vb temp/dembro32.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"../../release/" -FUtemp

../../release/de: $(BUILD_PP) de.dpr $(BUILD_DIR)/DEmbro/body.inc
	cd $(BUILD_DIR)/DEmbro && mkdir -p temp
	cd $(BUILD_DIR)/DEmbro && $(FPC) -vb de.pp -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"../../../release/" -FUtemp

../../release/de.exe: $(PP_LIST) $(BUILD_DIR)/body.inc
	cd $(BUILD_DIR)/DEmbro && mkdir -p temp
	cd $(BUILD_DIR)/DEmbro && $(FPC) -vb temp/de.dpr -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -an -ar -at -gl -FE"../../../release/" -FUtemp

lib: ../../release/$(LIBPREFIX)de32$(LIBEXT);

../../release/de32.dll: $(PP_LIST) de32.dpr $(BUILD_DIR)/body.inc $(BUILD_DIR)/load.inc
	cp de32.dpr temp
	$(FPC) temp/de32.dpr -dFLAG_FPC -Sd -O3 -al -an -ar -at -gl -FE"..\..\release\" -FU.\temp

../../release/libde32.so: $(BUILD_PP) de32.dpr $(BUILD_DIR)/DEmbro/body.inc $(BUILD_DIR)/DEmbro/load.inc
	cd $(BUILD_DIR)/DEmbro && mkdir -p temp
	cd $(BUILD_DIR)/DEmbro && $(FPC) -Cg de32.pp -dFLAG_FPC -dFLAG_CONSOLE -dFLAG_NOLOG -Sd -O3 -al -FE../../../release/ -FU./temp

headers: ../../release/headers/de32header.pp;

../../release/headers/de32header.pp: $(BUILD_DIR)/DEmbro/de32header.pp
	cp $(BUILD_DIR)/DEmbro/de32header.pp ../../release/headers

# UTILS
echopas:
	echo $(PAS_LIST)

echosources:
	echo $(SOURCES)

echodirs:
	echo $(SOURCES_DIRS)

echobuildtemppas:
	echo $(BUILD_PASTEMP)
