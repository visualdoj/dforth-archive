" 2010.12.07 # Doj
" Плагин для упрощения написания программ для DEmbro
" Этот файл следует положить куда-нибудь (например, в $VIM\vimfiles\plugin\)
" и прописать в ваш .vimrc строку вида
"     so $VIM\vimfiles\plugin\dembro.vim

if exists("b:dembro_load")
  finish
endif
let b:dembro_load = "1"

" создание нового файла на DEmbro
function! BufNewFile_DE()
   0put = substitute('// %date% # {NAME}', '%date%', strftime('%Y.%m.%d'), '')
   1put = '// {SUMMARY} '
   normal ggf{
   star
endfunction

" Маркеры для фолдинга
function DEmbroMarker()
  set fdm=marker
  set commentstring=//\ %s
  set foldmarker={{{,}}}
endfunction

autocmd BufNewFile *.de         call BufNewFile_DE()

au BufRead,BufNewFile *.df set filetype=dembro
au BufRead,BufNewFile *.de set filetype=dembro
au BufRead,BufNewFile *.dem set filetype=dembro
au BufRead,BufNewFile *         if &ft == 'dembro' | call DEmbroMarker() | endif
