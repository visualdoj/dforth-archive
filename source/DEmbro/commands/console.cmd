DECLARE(cr)
  begin
    with Machine^ do begin
      Writeln;
    end;
  end;
RUS SUMMARY начинает новую строку

DECLARE(emit)
  var
    I: Integer;
  begin
    with Machine^ do begin
      //Machine.Stack.Pop(@I, SizeOf(I));
      Write(Char(WOI));
    end;
  end;
RUS SUMMARY ( i) выводит символ с заданным номером

DECLARE(space)
  begin
    with Machine^ do begin
      Write(' ');
    end;
  end;
RUS SUMMARY выводит пробел

DECLARE(spaces)
  var
    I: TInt;
  begin
    with Machine^ do begin
      I := Machine.WOI;
      while I > 0 do begin
        SPACE(Machine, Command);
        Dec(I);
      end;
    end;
  end;
RUS SUMMARY ( i) выводит заданное число пробелов

DECLARE(clear)
    body()
  RUS SUMMARY ( i) стирает i последних символов

DECLARE(clear-lines, clear_lines)
    body()
  RUS SUMMARY ( i) стирает i последних строк

DECLARE(clear-screen, clear_screen)
    body()
  RUS SUMMARY стирает все символы экрана

DECLARE(set-font-color, set_font_color)
    body()
  RUS SUMMARY ( i) устанавливает i как цвет выводимого далее текста

DECLARE(set-background-color, set_background_color)
    body()
  RUS SUMMARY ( i) устанавливает i как цвет выводимого фона для текста

DECLARE(set-blink, set_blink)
    body()
  RUS SUMMARY ( f) устанавливает флаг мигания выводимого далее текста

define(`COLOR', `
  DECLARE(`COLOR_$1')
      body()
    RUS SUMMARY ( -i) кладёт цвет $1
')
COLOR(RED)
COLOR(GREEN)
COLOR(BLUE)
COLOR(YELLOW)
COLOR(PINK)
COLOR(CYAN)
COLOR(LIGHTRED)
COLOR(LIGHTGREEN)
COLOR(LIGHTBLUE)
COLOR(LIGHTYELLOW)
COLOR(LIGHTPINK)
COLOR(LIGHTCYAN)
COLOR(DARKRED)
COLOR(DARKGREEN)
COLOR(DARKBLUE)
COLOR(DARKYELLOW)
COLOR(DARKPINK)
COLOR(DARKCYAN)
