divert(`-1')
changecom(`//')

dnl Перевести строку
define(`BR', `<br>')
dnl Параграф
define(`PAR', `<p>$*</p>')

dnl Большой заголовок
define(`HEADER', `<h1>$*</h1>')
dnl Менее большой заголовок
define(`SUBHEADER', `<h2>$*</h2>')

dnl Выравнивания
define(`CENTER', `<div align="center">$*</div>')
define(`LEFT', `<div align="left">$*</div>')
define(`RIGHT', `<div align="right">$*</div>')

dnl Жирный текст
define(`BOLD', `<strong>$*</strong>')
dnl Наклонный текст
define(`ITALIC', `<em>$*</em>')
dnl Подчёркивание
define(`UNDERLINE', `<span style="text-decoration: underline;">$*</span>')
dnl Вычёркивание
define(`STRIKE', `<strike>$*</strike>')

dnl Нумерованный список
define(`LIST', `<OL>$*</OL>')
dnl Список с кружочками
define(`OLIST', `<UL>$*</UL>')
dnl Элемент списка
define(`ITEM', `<LI>$*</LI>')

dnl Ссылка
define(`LINK', `<a href="$1">shift($*)</a>')
dnl Якорь в тексте
define(`ANCHOR', `<a name="$1">shift($*)</a>')
dnl Ссылка на якорь
define(`ALINK', `<a href="`#'$1">shift($*)</a>')

dnl Цитата в кавычках-ёлочках
define(`QUOTE', `«$*»')
dnl Цитата в кавычках-лапках
define(`SUBQUOTE', `„$*“')
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
define(`CELL', `<td>$*</td>')

dnl Цвета
define(`COLOR', `<span style="color:$1">shift($*)</span>')
dnl Маргинальный набор цветов
define(`cRED', ``#'ff0000')
define(`cGREEN', ``#'00ff00')
define(`cBLUE', ``#'0000ff')
define(`RED', `COLOR(cRED,$*)')
define(`GREEN', `COLOR(cGREEN,$*)')
define(`BLUE', `COLOR(cBLUE,$*)')

divert
