" Vim syntax file
" Language:    DEMBRO
" Maintainer:  Doj V. J. Brьssow <cvjb@cvjb.de>
" Last Change: 07 Dec 2010 11:41:04 CEST
" Filenames:   *.de,*.dem
" URL:	       http://code.google.com/p/dforth/wiki/DEmbro
"
" Файл для подсветки синтаксиса программ на DEmbro. За основу взят стандартный
" файл syntax\forth.vim из вима.
" 
" Language:    FORTH
" Maintainer:  Christian V. J. Brьssow <cvjb@cvjb.de>
" Last Change: Di 07 Jul 2009 21:38:45 CEST
" Filenames:   *.fs,*.ft
" URL:	       http://www.cvjb.de/comp/vim/forth.vim

" $Id: forth.vim,v 1.12 2008/07/07 21:39:12 bruessow Exp $

" The list of keywords is incomplete, compared with the offical ANS
" wordlist. If you use this language, please improve it, and send me
" the patches.
"
" Before sending me patches, please download the newest version of this file
" from http://www.cvjb.de/comp/vim/forth.vim or http://www.vim.org/ (search
" for forth.vim).

" Many Thanks to...
"
" 2009-06-28:
" Josh Grams send a patch to allow the parenthesis comments at the
" beginning of a line. That patch also fixed a typo in one of the
" comments.
"
" 2008-02-09:
" Shawn K. Quinn <sjquinn at speakeasy dot net> send a big patch with
" new words commonly used in Forth programs or defined by GNU Forth.
"
" 2007-07-11:
" Benjamin Krill <ben at codiert dot org> send me a patch
" to highlight space errors.
" You can toggle this feature on through setting the
" flag forth_space_errors in you vimrc. If you have switched it on,
" you can turn off highlighting of trailing spaces in comments by
" setting forth_no_trail_space_error in your vimrc. If you do not want
" the highlighting of a tabulator following a space in comments, you
" can turn this off by setting forth_no_tab_space_error.
"
" 2006-05-25:
" Bill McCarthy <WJMc@...> and Ilya Sher <ilya-vim@...>
" Who found a bug in the ccomment line in 2004!!!
" I'm really very sorry, that it has taken two years to fix that
" in the offical version of this file. Shame on me.
" I think my face will be red the next ten years...
"
" 2006-05-21:
" Thomas E. Vaughan <tevaugha at ball dot com> send me a patch
" for the parenthesis comment word, so words with a trailing
" parenthesis will not start the highlighting for such comments.
" 
" 2003-05-10:
" Andrew Gaul <andrew at gaul.org> send me a patch for
" forthOperators.
"
" 2003-04-03:
" Ron Aaron <ron at ronware dot org> made updates for an
" improved Win32Forth support.
"
" 2002-04-22:
" Charles Shattuck <charley at forth dot org> helped me to settle up with the
" binary and hex number highlighting.
"
" 2002-04-20:
" Charles Shattuck <charley at forth dot org> send me some code for correctly
" highlighting char and [char] followed by an opening paren. He also added
" some words for operators, conditionals, and definitions; and added the
" highlighting for s" and c".
"
" 2000-03-28:
" John Providenza <john at probo dot com> made improvements for the
" highlighting of strings, and added the code for highlighting hex numbers.
"


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Synchronization method
syn sync ccomment
syn sync maxlines=200

" Some special, non-FORTH keywords
syn keyword dembroTodo contained TODO FIXME XXX
syn match dembroTodo contained 'Copyright\(\s([Cc])\)\=\(\s[0-9]\{2,4}\)\='

" Characters allowed in keywords
" I don't know if 128-255 are allowed in ANS-FORTH
if version >= 600
    setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
else
    set iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
endif

" when wanted, highlight trailing white space
if exists("dembro_space_errors")
    if !exists("dembro_no_trail_space_error")
        syn match dembroSpaceError display excludenl "\s\+$"
    endif
    if !exists("dembro_no_tab_space_error")
        syn match dembroSpaceError display " \+\t"me=e-1
    endif
endif

" Keywords

" basic mathematical and logical operators
syn keyword dembroOperators + - * / mod /mod negate abs min max
syn keyword dembroOperators and or xor not lshift rshift invert 2* 2/ 1+
syn keyword dembroOperators 1- 2+ 2- 8* under+
syn keyword dembroOperators m+ */ */mod m* um* m*/ um/mod fm/mod sm/rem
syn keyword dembroOperators d+ d- dnegate dabs dmin dmax d2* d2/
syn keyword dembroOperators f+ f- f* f/ fnegate fabs fmax fmin floor fround
syn keyword dembroOperators f** fsqrt fexp fexpm1 fln flnp1 flog falog fsin
syn keyword dembroOperators fcos fsincos ftan fasin facos fatan fatan2 fsinh
syn keyword dembroOperators fcosh ftanh fasinh facosh fatanh f2* f2/ 1/f
syn keyword dembroOperators f~rel f~abs f~
syn keyword dembroOperators 0< 0<= 0<> 0= 0> 0>= < <= <> = > >= u< u<=
syn keyword dembroOperators u> u>= d0< d0<= d0<> d0= d0> d0>= d< d<= d<>
syn keyword dembroOperators d= d> d>= du< du<= du> du>= within ?negate
syn keyword dembroOperators ?dnegate 

" stack manipulations
syn keyword dembroStack drop nip dup over tuck swap rot lrot rrot 
syn keyword dembroStack bdrop bnip bdup bover btuck bswap brot blrot brrot 
syn keyword lrotn rrotn ?dup pick roll
syn keyword dembroRStack >r r> r@ rdrop

" stack pointer manipulations
syn keyword dembroSP sp@ sp! fp@ fp! rp@ rp! lp@ lp!

" address operations
syn keyword dembroMemory @ ! +! c@ c! 2@ 2! f@ f! sf@ sf! df@ df!
syn keyword dembroAdrArith chars char+ cells cell+ cell align aligned floats
syn keyword dembroAdrArith float+ float falign faligned sfloats sfloat+
syn keyword dembroAdrArith sfalign sfaligned dfloats dfloat+ dfalign dfaligned
syn keyword dembroAdrArith maxalign maxaligned cfalign cfaligned
syn keyword dembroAdrArith address-unit-bits allot allocate here
syn keyword dembroMemBlks move erase cmove cmove> fill blank

" conditionals
syn keyword dembroCond if else endif then case of endof endcase ?dup-if
syn keyword dembroCond ?dup-0=-if ahead cs-pick cs-roll catch throw within

" iterations
syn keyword dembroLoop begin while repeat until again
syn keyword dembroLoop ?do loop +do -do do +loop -loop
syn keyword dembroLoop unloop leave ?leave exit done for next

" File keywords
syn keyword dembroFileMode file-w file-r
syn keyword dembroFileWords file-open close-close
syn keyword dembroFileWords file-read
syn keyword dembroFileWords file-write
syn keyword dembroFileWords file-size

" numbers
syn keyword dembroMath decimal hex base
syn match dembroInteger '\<-\=[0-9.]*[0-9.]\+\>'
syn match dembroInteger '\<&-\=[0-9.]*[0-9.]\+\>'
" recognize hex and binary numbers, the '$' and '%' notation is for gforth
syn match dembroInteger '\<\$\x*\x\+\>' " *1* --- dont't mess
syn match dembroInteger '\<\x*\d\x*\>'  " *2* --- this order!
syn match dembroInteger '\<\h\x*\x\+\>'
syn match dembroInteger '\<%[0-1]*[0-1]\+\>'
syn match dembroFloat '\<-\=\d*[.]\=\d\+[DdEe]\d\+\>'
syn match dembroFloat '\<-\=\d*[.]\=\d\+[DdEe][-+]\d\+\>'

" Magic chars in strings
syn match dembroMagicChar '\^.'

" Strings
syn region dembroString matchgroup=dembroQuote start=+\k*\" + end=+"\k*+ contains=dembroMagicChar
syn match dembroQuote 'char .'
syn match dembroQuote '\[char\] .'

" Comments
syn match dembroComment 'summary\s.*$' contains=dembroTodo,dembroSpaceError
syn match dembroComment '\\\s.*$' contains=dembroTodo,dembroSpaceError
syn region dembroComment start='\\S\s' end='.*' contains=dembroTodo,dembroSpaceError
syn match dembroComment '//\s.*$' contains=dembroTodo,dembroSpaceError
syn region dembroComment start='//S\s' end='.*' contains=dembroTodo,dembroSpaceError
syn match dembroComment '\.(\s[^)]*)' contains=dembroTodo,dembroSpaceError
syn region dembroComment start='detail' end='\\detail' contains=dembroTodo,dembroSpaceError
syn region dembroComment start='\(^\|\s\)\zs(\s' skip='\\)' end=')' contains=dembroTodo,dembroSpaceError
syn region dembroComment start='/\*' end='\*/' contains=dembroTodo,dembroSpaceError

" new words
syn match dembroClassDef '\<:class\s*[^ \t]\+\>'
syn match dembroObjectDef '\<:object\s*[^ \t]\+\>'
syn match dembroColonDef '\<:m\?\s*[^ \t]\+\>'
syn match dembroColonDef ':\k* \k*'
syn match dembroEndOfColonDef '\k*;'
syn keyword dembroEndOfColonDef ; ;M ;m
syn keyword dembroEndOfClassDef ;class
syn keyword dembroEndOfObjectDef ;object
syn keyword dembroDefine constant 2constant fconstant variable 2variable
syn keyword dembroDefine fvariable create user value to defer is does> immediate
syn keyword dembroDefine compile-only compile restrict interpret postpone execute
syn keyword dembroDefine literal create-interpret/compile interpretation>
syn keyword dembroDefine <interpretation compilation> <compilation ] lastxt
syn keyword dembroDefine comp' postpone, find-name name>int name?int name>comp
syn keyword dembroDefine name>string state c; cvariable
syn keyword dembroDefine , 2, f, c, 
syn match dembroDefine "\[ifdef]"
syn match dembroDefine "\[ifundef]"
syn match dembroDefine "\[then]"
syn match dembroDefine "\[endif]"
syn match dembroDefine "\[else]"
syn match dembroDefine "\[?do]"
syn match dembroDefine "\[do]"
syn match dembroDefine "\[loop]"
syn match dembroDefine "\[+loop]"
syn match dembroDefine "\[next]"
syn match dembroDefine "\[begin]"
syn match dembroDefine "\[until]"
syn match dembroDefine "\[again]"
syn match dembroDefine "\[while]"
syn match dembroDefine "\[repeat]"
syn match dembroDefine "\[comp']"
syn match dembroDefine "'"
syn match dembroDefine '\<\[\>'
syn match dembroDefine "\[']"
syn match dembroDefine '\[compile]'

" i386 assembler
syn keyword dembroI386mnemonics NOP MOV PUSH POP ADD SUB INC DEC
syn keyword dembroI386mnemonics nop mov push pop add sub inc dec
syn keyword dembroI386registers EAX ECX EDX EBX ESP EBP ESI EDI
syn keyword dembroI386registers eax ecx edx ebx esp ebp esi edi
syn match dembroI386spec 'b\['
syn match dembroI386spec 'w\['
syn match dembroI386spec 'd\['

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_dembro_syn_inits")
    if version < 508
	let did_dembro_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif

    " The default methods for highlighting. Can be overriden later.
    HiLink dembroTodo Todo
    HiLink dembroOperators Operator
    HiLink dembroMath Number
    HiLink dembroInteger Number
    HiLink dembroFloat Float
    HiLink dembroStack Special
    HiLink dembroRstack Special
    HiLink dembroFStack Special
    HiLink dembroSP Special
    HiLink dembroMemory Function
    HiLink dembroAdrArith Function
    HiLink dembroMemBlks Function
    HiLink dembroCond Conditional
    HiLink dembroLoop Repeat
    HiLink dembroColonDef Define
    HiLink dembroEndOfColonDef Define
    HiLink dembroDefine Define
    HiLink dembroDebug Debug
    HiLink dembroAssembler Include
    HiLink dembroCharOps Character
    HiLink dembroConversion String
    HiLink dembroForth Statement
    HiLink dembroVocs Statement
    HiLink dembroMagicChar Statement
    HiLink dembroString String
    HiLink dembroQuote Statement
    HiLink dembroComment Comment
    HiLink dembroClassDef Define
    HiLink dembroEndOfClassDef Define
    HiLink dembroObjectDef Define
    HiLink dembroEndOfObjectDef Define
    HiLink dembroInclude Include
    HiLink dembroLocals Type " nothing else uses type and locals must stand out
    HiLink dembroDeprecated Error " if you must, change to Type
    HiLink dembroFileMode Function
    HiLink dembroFileWords Statement
    HiLink dembroBlocks Statement
    HiLink dembroSpaceError Error
    HiLink dembroI386mnemonics String
    HiLink dembroI386registers Function
    HiLink dembroI386spec Define

    delcommand HiLink
endif

let b:current_syntax = "dembro"

" vim:ts=8:sw=4:nocindent:smartindent:
