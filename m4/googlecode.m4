dnl(
changequote(~,|)
define(~file|, ~dnl($1)|)
define(~_doc_enabled|, ~0|)
define(~_doc_ext|, ~.wiki|)
define(~_out|, ~|)
define(~_doc_write|, ~define(~_out|, _out()$1)|)
define(~_doc_change_ext|, ~define(~_doc_ext|, $1)|)
define(~_doc_entry|, ~_doc_write(_h1($1)
$1 $2 
$3
_DOC_CUT_ doc_$1~|_doc_ext()
)|)
define(~_doc_article|, ~_doc_write($1 $2)|)
define(~_b|, ~*$1*|)
define(~_i|, ~*$1*|)
define(~_u|, ~*$1*|)
define(~_h1|, ~= $1 =|)
define(~_h2|, ~== $1 ==|)
define(~_h3|, ~=== $1 ===|)
define(~_h4|, ~==== $1 ====|)
define(~_h5|, ~===== $1 =====|)
define(~_h6|, ~====== $1 ======|)
define(~_list|, ~define(~_item|, ~# $1|)_doc_write($1)|)
define(~_code|, ~{{{
$1
}}}|)
define(~link|, ~[$1|$2]|)
)
