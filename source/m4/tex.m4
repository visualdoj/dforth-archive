divert(`-1')
changecom(`###')
include(`util.m4')

NUMERATOR(`DIVERT',1)

define(`BR', `\\')
define(`PAR', `

CS($*)

')

define(`HEADER', `{\huge CS($*)}')
define(`SUBHEADER', `{\Large CS($*)}')

define(`CENTER', `\begin{center} CS($*) \end{center}')
define(`LEFT', `\begin{left} CS($*) \end{left}')
define(`RIGHT', `\begin{right} CS($*) \end{right}')

define(`BOLD', `\textbf{CS($*)}')
define(`ITALIC', `\textit{CS($*)}')
define(`UNDERLINE', `\textsl{CS($*)}')
define(`STRIKE', `CS($*)')

define(`LIST', `\begin{enumerate}CS($*)\end{enumerate}')
define(`OLIST', `')
define(`ITEM', `\item CS($*)')

define(`LIST', `divert(`-1')
    pushdef(`ITEM', `\item 'CS(CONCAT($,*)))
    pushdef(`_LIST', `popdef(`ITEM')popdef(`_LIST')\end{enumerate}')
divert(`0')\begin{enumerate}')
define(`OLIST', `divert(`-1')
    pushdef(`ITEM', `\item 'CS(CONCAT($,*)))
    pushdef(`_LIST', `popdef(`ITEM')popdef(`_LIST')\end{enumerate}')
divert(`0')\begin{enumerate}')

define(`LINK', `CS(shift($*))') dnl `\href{CS(shift($*))}{$1}')
define(`ANCHOR', `CS(shift($*))')
define(`ALINK', `CS(shift($*))')

define(`QUOTE', `«CS($*)»')
define(`SUBQUOTE', `„CS($*)”')
define(`sTIRET', `--')
define(`sLT', `<')
define(`sGT', `>')
define(`sAMP', `\&')

define(`TABLE', `\begin{tabular}{l c r}')
define(`_TABLE', `\end{tabular}')
define(`ROW', `define(`IS_ROW', 1)')
define(`_ROW', `\\')
define(`CELL', `CS($*) ifelse(IS_ROW,`0',`&',`define(`IS_ROW',`0')')')

define(`COLOR', `shift(CS($*))')
define(`cRED', `#ff0000')
define(`cGREEN', `#00ff00')
define(`cBLUE', `#0000ff')
define(`cYELLOW', `#ffff00')
define(`cPINK', `#ff00ff')
define(`cTURQUOISE', `#00ffff')
define(`RED', `COLOR(cRED,CS($*))')
define(`GREEN', `COLOR(cGREEN,CS($*))')
define(`BLUE', `COLOR(cBLUE,CS($*))')
define(`')

define(`DIVERT_REFERENCES', DIVERT)
NUMERATOR(`REFERENCES_COUNT', 0)
define(`REFERENCES', `divert(`-1')
    pushdef(`ITEM', `divert(`-1')REFERENCES_COUNT divert(DIVERT_REFERENCES)\bibitem{} CS('CONCAT($,*)`)')
    pushdef(`_REFERENCES', `popdef(`ITEM')popdef(`_REFERENCES')divert(`0')\begin{thebibliography}{REFERENCES_COUNT}
undivert(DIVERT_REFERENCES)
\end{thebibliography}')
divert(DIVERT_REFERENCES)')

divert
