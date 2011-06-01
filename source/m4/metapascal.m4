divert(`-1')
dnl Если первый параметр не пуст, подставляет второй
define(`IFFAT',`ifelse($1,`',,$2)')

dnl Обнуляет значение идентификатора
define(`SETNULL',`define(`$1',`')')
dnl Склеивает два своих параметра
define(`CONCAT',`$1$2')
dnl Добавляет к идентификатору дополнительные данные
define(`APPEND',`define(`$1',indir(`$1') $2)')

dnl Лямбды
dnl см. http://denisgolovan.livejournal.com/11297.html
dnl или http://www.mail-archive.com/m4-discuss@gnu.org/msg00356.html
define(`M4LAMBDA',
`pushdef(`$0', patsubst(``$1'',`\$_\([0-9]*\)',`$\1'))$0(popdef(`$0')_$0')dnl
define(`_M4LAMBDA', `$@)')

dnl Проверка утверждений в Realtime
define(`ASSERT',`if $1 then begin Log("assert error (__file__,__line__): not $1"); $2 end')
define(`IN',`ASSERT($1,Exit)')
define(`OUT',`ASSERT($1,)')

dnl Конструкция RETURN
dnl Можно использовать без параметров, подставится Exit
dnl С параметром подставится begin Result := параметр; Exit; end;
define(`RETURN',`begin IFFAT($1,Result := $1;) Exit; end')

define(`PROTOTYPE',`define($1,$2)') dnl PROTOTYPE(SomeFunc, function OnClick(Button: Integer): Boolean;)

define(`INIT',`begin ifelse($1,`',with $2,$1 := $2; with $1) do begin $3 end; end')

define(`FOR',`for $1 := 0 to $2 - 1 do begin $3 end')
define(`ARRFOR',`FOR($1,High($2),$3)')

dnl objects
define(`OBJECT',`dnl(
    define(`OBJECT_NAME',$1)
    define(`TOBJECT_NAME',T$1)
    define(`POBJECT_NAME',P$1)
    SETNULL(OBJECT_IMPLEMENTATION)
    SETNULL(OBJECT_PRIVATE)
    SETNULL(OBJECT_PROTECTED)
    SETNULL(OBJECT_PUBLIC))
T$1 = object$2 dnl
')
define(`_OBJECT',`dnl
  private OBJECT_PRIVATE
  protected OBJECT_PROTECTED
  public OBJECT_PUBLIC
end;
')
define(`POBJECT', `P$1 = ^T$1; OBJECT($1,$2,$3)')
define(`FMETHOD', `dnl
    define(`METHOD_NAME', $1) dnl
  function $1$2: $3; $4 dnl 
    SETNULL(METHOD_LOCALVARS) dnl
    define(`METHOD_BODY', $5) dnl
    APPEND(`OBJECT_IMPLEMENTATION', 
           ` function TOBJECT_NAME.$1$2: $3;dnl 
             IFFAT(METHOD_LOCALVARS,var METHOD_LOCALVARS) dnl
             begin dnl
               METHOD_BODY dnl
             end;')')
define(`PMETHOD', `procedure $1$2; $3')
define(`PRIVATE', `APPEND(`OBJECT_PRIVATE', F$1: $2;)')
define(`PROTECTED', `APPEND(`OBJECT_PROTECTED', F$1: $2;) dnl
                     APPEND(`OBJECT_PUBLIC', property $1: $2 read F$1;)')

dnl Объявляем глобальные переменные
SETNULL(`OBJECT_IMPLEMENTATION')
SETNULL(OBJECT_PRIVATE) dnl
SETNULL(OBJECT_PROTECTED) dnl
SETNULL(OBJECT_PUBLIC) dnl
)
divert
