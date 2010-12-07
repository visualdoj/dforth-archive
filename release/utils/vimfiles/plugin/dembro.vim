" 2010.12.07 # Doj
" ������ ��� ��������� ��������� �������� ��� DEmbro
" ���� ���� ������� �������� ����-������ (��������, � $VIM\vimfiles\plugin\)
" � ��������� � ��� .vimrc ������ ����
"     so $VIM\vimfiles\plugin\dembro.vim

if exists("b:dembro_load")
  finish
endif
let b:dembro_load = "1"

" �������� ������ ����� �� DEmbro
function! BufNewFile_DE()
   0put = substitute('// %date% # {NAME}', '%date%', strftime('%Y.%m.%d'), '')
   1put = '// {SUMMARY} '
   normal ggf{
   star
endfunction

" ������� ��� ��������
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
