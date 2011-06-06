divert(`-1')
changecom(`###')

define(`CONCAT',`$1$2')

define(`NUMERATOR',`define(`$1_VALUE',`$2')define(`$1',`$1_VALUE`'define(`$1_VALUE',incr($1_VALUE))')')
NUMERATOR(`DIVERT',1)

define(`CS', `patsubst(`$*',`[,]',`, ')')

define(`BR', `\\')
define(`PAR', `

CS($*)

')

define(`HEADER', `\Large{CS($*)}')
define(`SUBHEADER', `\subsection{CS($*)}')

define(`CENTER', `\begin{center} CS($*) \end{center}')

define(`BOLD', `\textbf{CS($*)}')
define(`ITALIC', `\textit{CS($*)}')
define(`UNDERLINE', `CS($*)')

define(`LIST', `\begin{enumerate}CS($*)\end{enumerate}')
define(`OLIST', `')
define(`ITEM', `\item CS($*)')

define(`LINK', `\href{CS(shift($*))}{$1}')
define(`ANCHOR', `')

define(`DIVERT_REFERENCES', DIVERT)
NUMERATOR(`REFERENCES_COUNT', 0)
define(`REFERENCES', `divert(`-1')
    pushdef(`ITEM', `divert(`-1')REFERENCES_COUNT divert(DIVERT_REFERENCES)\bibitem{} CS('CONCAT($,*)`)')
    pushdef(`_REFERENCES', `popdef(`ITEM')popdef(`_REFERENCES')divert(`0')\begin{thebibliography}{REFERENCES_COUNT}
undivert(DIVERT_REFERENCES)
\end{thebibliography}')
divert(DIVERT_REFERENCES)')

divert
