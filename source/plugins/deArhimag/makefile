OUT=..\..\..\release\plugins\deArhimag.dll
.PHONY: all
.PHONY: test

all:
	mingw32-g++ -c deArhimag.cpp -o temp\deArhimag.o
	mingw32-g++ -shared -o $(OUT) -Wl,--out-implib,temp\libdeArhimagdll.a temp\deArhimag.o

test:
	mingw32-g++ -c deArhimagTest.cpp -o temp\deArhimag.o
	mingw32-g++ -shared -o $(OUT) -Wl,--out-implib,temp\libdeArhimagdll.a temp\deArhimag.o
