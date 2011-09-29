dnl(
define(`file', `$1')
define(`_out', `')
define(`RETURN', `begin ifelse($1,`',,Result := $1;) Exit; end')
dnl(changequote(`!@#$%', `%$#@!'))
)dnl
