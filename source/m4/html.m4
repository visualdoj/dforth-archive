divert(`-1')
changecom(`###')

define(`CONCAT',`$1$2')

define(`M4LAMBDA',
`pushdef(`$0', patsubst(``$1'',`\$_\([0-9]*\)',`$\1'))$0(popdef(`$0')_$0')dnl
define(`_M4LAMBDA', `$@)')

define(`CS', `patsubst(`$*',`[,]',`, ')')

dnl Перевести строку
define(`BR', `<br>')
dnl Параграф
define(`PAR', `<p>CS($*)</p>')

dnl Большой заголовок
define(`HEADER', `<h1>CS($*)</h1>')
dnl Менее большой заголовок
define(`SUBHEADER', `<h2>CS($*)</h2>')

dnl Выравнивания
define(`CENTER', `<div align="center">CS($*)</div>')
define(`LEFT', `<div align="left">CS($*)</div>')
define(`RIGHT', `<div align="right">CS($*)</div>')

dnl Жирный текст
define(`BOLD', `<strong>CS($*)</strong>')
dnl Наклонный текст
define(`ITALIC', `<em>CS($*)</em>')
dnl Подчёркивание
define(`UNDERLINE', `<span style="text-decoration: underline;">CS($*)</span>')
dnl Вычёркивание
define(`STRIKE', `<strike>CS($*)</strike>')

dnl Нумерованный список
define(`LIST', `pushdef(`ITEM', `<LI>'CONCAT($,*))<OL>')
define(`_LIST', `popdef(`ITEM')</OL>')
dnl Список с кружочками
define(`OLIST', `pushdef(`ITEM', `<LI>'CONCAT($,*))<UL>')
define(`_OLIST', `popdef(`ITEM')</UL>')

dnl Ссылка
define(`LINK', `<a href="$1">CS(shift($*))</a>')
dnl Якорь в тексте
define(`ANCHOR', `<a name="$1">CS(shift($*))</a>')
dnl Ссылка на якорь
define(`ALINK', `<a href="`#'$1">CS(shift($*))</a>')

dnl Цитата в кавычках-ёлочках
define(`QUOTE', `&#171;CS($*)&#187;')
dnl Цитата в кавычках-лапках
define(`SUBQUOTE', `&#8222;CS($*)&#8221;')
dnl Тире
define(`TIRET', `—')

dnl Знаки < и >
define(`LT', `&lt;')
define(`GT', `&gt;')
dnl Амперсанд
define(`AMP', `&amp;')

define(`TABLE', `<table>')
define(`_TABLE', `</table>')
define(`ROW', `<tr>')
define(`_ROW', `</tr>')
define(`CELL', `<td>CS($*)</td>')

dnl Цвета
define(`COLOR', `<span style="color:$1">shift(CS($*))</span>')
dnl Маргинальный набор цветов
define(`cRED', `#ff0000')
define(`cGREEN', `#00ff00')
define(`cBLUE', `#0000ff')
define(`cYELLOW', `#ffff00')
define(`cPINK', `#ff00ff')
define(`cTURQUOISE', `#00ffff')
define(`RED', `COLOR(cRED,CS($*))')
define(`GREEN', `COLOR(cGREEN,CS($*))')
define(`BLUE', `COLOR(cBLUE,CS($*))')

divert
