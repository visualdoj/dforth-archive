divert(`-1')

dnl Перевести строку
define(`BR', `<br>')
dnl Параграф
define(`PAR', `<p>$*</p>')

dnl Большой заголовок
define(`HEADER', `<h1>$*</h1>')
dnl Менее большой заголовок
define(`SUBHEADER', `<h2>$*</h2>')

dnl Жирный текст
define(`BOLD', `<b>$*</b>')
dnl Наклонный текст
define(`ITALIC', `<i>$*</i>')
dnl Подчёркивание
define(`UNDERLINE', `<u>$*</u>')

dnl Нумерованный список
define(`LIST', `<OL>$*</OL>')
dnl Список с кружочками
define(`OLIST', `<UL>$*</UL>')
dnl Элемент списка
define(`ITEM', `<LI>$*</LI>')

dnl Ссылка
define(`LINK', `<a href="$1">shift($*)</a>')
dnl Якорь в тексте
define(`ANCHOR', `')

dnl Цитата в кавычках-ёлочках
define(`QUOTE', `«$*»')
dnl Цитата в кавычках-лапках
define(`SUBQUOTE', `„$*“')
dnl Тире
define(`TIRET', `—')

dnl Знаки < и >
define(`LT', `&lt;')
define(`GT', `&gt;')
dnl Амперсант
define(`AMP', `&amp;')

divert
