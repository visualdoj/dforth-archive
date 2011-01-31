	.file "Callback.pp"
# Begin asmlist al_begin
# End asmlist al_begin
# Begin asmlist al_stabs
# End asmlist al_stabs
# Begin asmlist al_procedures

.section .text.n_p$callback_loop$tcallback
	.balign 16,0x90
.globl	P$CALLBACK_LOOP$TCALLBACK
P$CALLBACK_LOOP$TCALLBACK:
# Temps allocated between ebp-8 and ebp-4
# [Callback.pp]
# [10] begin
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp
	movl	%ebx,-8(%ebp)
# Var Callback located at ebp+8
# Var R located at ebp-4
# [12] R := Callback( 1001,  2002,  3003,  4004);
	pushl	$4004
	pushl	$3003
	pushl	$2002
	pushl	$1001
	movl	8(%ebp),%eax
	call	*%eax
	movl	%eax,-4(%ebp)
# [13] Writeln('Callback( 1001,  2002,  3003,  4004) = ', R);
	call	fpc_get_output
	movl	%eax,%ebx
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld1,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	-4(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%eax
	call	fpc_writeln_end
	call	FPC_IOCHECK
# [18] end;
	movl	-8(%ebp),%ebx
	leave
	ret	$4

.section .text.n_p$callback_loop2$tcallback$longint$longint$longint$longint
	.balign 16,0x90
.globl	P$CALLBACK_LOOP2$TCALLBACK$LONGINT$LONGINT$LONGINT$LONGINT
P$CALLBACK_LOOP2$TCALLBACK$LONGINT$LONGINT$LONGINT$LONGINT:
# Temps allocated between ebp-8 and ebp-4
# [23] begin
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp
	movl	%ebx,-8(%ebp)
# Var Callback located at ebp+8
# Var A located at ebp+12
# Var B located at ebp+16
# Var C located at ebp+20
# Var D located at ebp+24
# Var R located at ebp-4
# [24] Writeln('Loop! ', Cardinal(@Callback));
	call	fpc_get_output
	movl	%eax,%ebx
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld2,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	8(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_uint
	call	FPC_IOCHECK
	movl	%ebx,%eax
	call	fpc_writeln_end
	call	FPC_IOCHECK
# [25] R := Callback(A, B, C, D);
	pushl	24(%ebp)
	pushl	20(%ebp)
	pushl	16(%ebp)
	pushl	12(%ebp)
	movl	8(%ebp),%eax
	call	*%eax
	movl	%eax,-4(%ebp)
# [26] Writeln('Callback(', A, ', ', B, ', ', C, ', ', D, ') = ', R);
	call	fpc_get_output
	movl	%eax,%ebx
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld3,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	12(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld4,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	16(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld4,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	20(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld4,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	24(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%edx
	movl	$_$CALLBACK$_Ld5,%ecx
	movl	$0,%eax
	call	fpc_write_text_shortstr
	call	FPC_IOCHECK
	movl	-4(%ebp),%ecx
	movl	%ebx,%edx
	movl	$0,%eax
	call	fpc_write_text_sint
	call	FPC_IOCHECK
	movl	%ebx,%eax
	call	fpc_writeln_end
	call	FPC_IOCHECK
# [31] end;
	movl	-8(%ebp),%ebx
	leave
	ret	$20
	.long	EDATA_P$CALLBACK

.section .text.n__p$callback_main
	.balign 16,0x90
.globl	PASCALMAIN
PASCALMAIN:
.globl	_P$CALLBACK_main
_P$CALLBACK_main:
# Temps allocated between ebp+0 and ebp+0
# [37] end.
	pushl	%ebp
	movl	%esp,%ebp
	call	FPC_LIBINITIALIZEUNITS
	leave
	ret
# End asmlist al_procedures
# Begin asmlist al_globals

.section .data.n_THREADVARLIST_P$CALLBACK
	.balign 4
.globl	THREADVARLIST_P$CALLBACK
THREADVARLIST_P$CALLBACK:
	.long	0

.section .data.n_INITFINAL
	.balign 4
.globl	INITFINAL
INITFINAL:
	.long	3,0
	.long	INIT$_SYSTEM
	.long	0
	.long	INIT$_FPINTRES
	.long	0
	.long	INIT$_OBJPAS
	.long	FINALIZE$_OBJPAS

.section .data.n_FPC_THREADVARTABLES
	.balign 4
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	5
	.long	THREADVARLIST_SYSTEM
	.long	THREADVARLIST_FPINTRES
	.long	THREADVARLIST_OBJPAS
	.long	THREADVARLIST_SYSINITPAS
	.long	THREADVARLIST_P$CALLBACK

.section .data.n_FPC_RESOURCESTRINGTABLES
	.balign 4
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.long	0

.section .fpc.n_version
	.balign 16
	.ascii	"FPC 2.4.0 [2009/12/18] for i386 - Win32"

.section .data.n___heapsize
	.balign 4
.globl	__heapsize
__heapsize:
	.long	0

.section .data.n___fpc_valgrind
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
# End asmlist al_globals
# Begin asmlist al_const
# End asmlist al_const
# Begin asmlist al_typedconsts

.section .rodata.n__$CALLBACK$_Ld1
	.balign 4
.globl	_$CALLBACK$_Ld1
_$CALLBACK$_Ld1:
	.ascii	"'Callback( 1001,  2002,  3003,  4004) = \000"

.section .rodata.n__$CALLBACK$_Ld2
	.balign 4
.globl	_$CALLBACK$_Ld2
_$CALLBACK$_Ld2:
	.ascii	"\006Loop! \000"

.section .rodata.n__$CALLBACK$_Ld3
	.balign 4
.globl	_$CALLBACK$_Ld3
_$CALLBACK$_Ld3:
	.ascii	"\011Callback(\000"

.section .rodata.n__$CALLBACK$_Ld4
	.balign 4
.globl	_$CALLBACK$_Ld4
_$CALLBACK$_Ld4:
	.ascii	"\002, \000"

.section .rodata.n__$CALLBACK$_Ld5
	.balign 4
.globl	_$CALLBACK$_Ld5
_$CALLBACK$_Ld5:
	.ascii	"\004) = \000"
# End asmlist al_typedconsts
# Begin asmlist al_rotypedconsts
# End asmlist al_rotypedconsts
# Begin asmlist al_threadvars
# End asmlist al_threadvars
# Begin asmlist al_imports
# End asmlist al_imports
# Begin asmlist al_exports

.section .edata
.globl	EDATA_P$CALLBACK
EDATA_P$CALLBACK:
	.long	0
	.long	0
	.short	0
	.short	0
	.rva	.Lj123
	.long	1
	.long	2
	.long	2
	.rva	.Lj124
	.rva	.Lj125
	.rva	.Lj126
.Lj123:
	.ascii	"CALLBACK.dll\000"
	.balign 4,0
.Lj124:
	.rva	P$CALLBACK_LOOP2$TCALLBACK$LONGINT$LONGINT$LONGINT$LONGINT
	.rva	P$CALLBACK_LOOP$TCALLBACK
	.balign 4,0
.Lj125:
	.rva	.Lj127
	.rva	.Lj128
	.balign 4,0
.Lj126:
	.short	1
	.short	0
	.balign 4,0
	.balign 2,0
.Lj127:
	.ascii	"Loop\000"
	.balign 2,0
.Lj128:
	.ascii	"Loop2\000"
# End asmlist al_exports
# Begin asmlist al_resources
# End asmlist al_resources
# Begin asmlist al_rtti
# End asmlist al_rtti
# Begin asmlist al_dwarf_frame
# End asmlist al_dwarf_frame
# Begin asmlist al_dwarf_info
# End asmlist al_dwarf_info
# Begin asmlist al_dwarf_abbrev
# End asmlist al_dwarf_abbrev
# Begin asmlist al_dwarf_line
# End asmlist al_dwarf_line
# Begin asmlist al_picdata
# End asmlist al_picdata
# Begin asmlist al_resourcestrings
# End asmlist al_resourcestrings
# Begin asmlist al_end
# End asmlist al_end

