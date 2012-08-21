// os
{$IFDEF WINDOWS} { ce + win32 + win64 } {$ENDIF}
{$IFDEF WIN32} {$ENDIF}
{$IFDEF LINUX} {$DEFINE LINUX_or_BSD} {$ENDIF}
{$IFDEF BSD} {$DEFINE LINUX_or_BSD} {$ENDIF}
{$IFDEF UNIX} { Linux/BSD/OS X and Solaris.
                BeOS too if it ever released again. } {$ENDIF}

// cpu
{$IFDEF CPUI386}    { 32-bit PC code here. }  {$ENDIF}  
{$IFDEF CPUX86_64}  { aka AMD64. 64-bit PC code here. }  {$ENDIF}
{$IFDEF POWERPC}    { 32-bit powerpc specific code here }  {$ENDIF}   
{$IFDEF POWERPC64}  { 64-bit powerpc specific code here }  {$ENDIF}
{$IFDEF M68K}       { m68k, Motorola 68010+ is not supported in 2.0+
                      at the moment, but might be resurrected. } {$ENDIF}
{$IFDEF SPARC}      { 32-bit Sparc support } {$ENDIF}  
{$IFDEF SPARC64}    { 64-bit Sparc support is partially done,
                      but not releaseworthy yet. } {$ENDIF}  
{$IFDEF ARM}        { 32-bit ARM support. } {$ENDIF}

// bits
{$IFDEF CPU32} {$DEFINE BITS_32} {$ENDIF}
{$IFDEF CPU64} {$DEFINE BITS_64} {$ENDIF}
{$IFNDEF BITS_32}{$IFNDEF BITS_64} {$DEFINE BITS_ELSE} {$ENDIF}{$ENDIF}

// bytes order
{$IFDEF ENDIAN_LITTLE} { $1234 -> |$34|$12| } {$ENDIF}
{$IFDEF ENDIAN_BIG} { $1234 -> |$12|$32| } {$ENDIF}
