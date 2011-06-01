divert(`-1')

define(`BR', `\\')
define(`PAR', `

$*

')

define(`HEADER', `\section{$*}')
define(`SUBHEADER', `\subsection{$*}')

define(`BOLD', `\textbf{$*}')
define(`ITALIC', `\textit{$*}')
define(`UNDERLINE', `$*')

define(`LIST', `\begin{enumerate}$*\end{enumerate}')
define(`OLIST', `')
define(`ITEM', `\item $*')

define(`LINK', `\href{shift($*)}{$1}')
define(`ANCHOR', `')

divert
