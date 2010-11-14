OUT=..\..\..\release\plugins\deArhimag.dll

all:
	mingw32-g++ -c deArhimag.cpp -o temp\deArhimag.o
	mingw32-g++ -shared -o $(OUT) -Wl,--out-implib,temp\libdeArhimagdll.a temp\deArhimag.o
