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
    body(Console.Clear(WOI);)
  RUS SUMMARY ( i) стирает i последних символов

DECLARE(clear-line, clear_line)
    body(Console.ClearLine;)
  RUS SUMMARY стирает текущую линию

DECLARE(clear-screen, clear_screen)
    body(Console.ClearScreen;)
  RUS SUMMARY стирает все символы экрана

DECLARE(set-font-color, set_font_color)
    body(Console.SetFontColor(WOI);)
  RUS SUMMARY ( i) устанавливает i как цвет выводимого далее текста

DECLARE(set-background-color, set_background_color)
    body(Console.SetBackgroundColor(WOI);)
  RUS SUMMARY ( i) устанавливает i как цвет выводимого фона для текста

DECLARE(set-blink, set_blink)
    body()
  RUS SUMMARY ( f) устанавливает флаг мигания выводимого далее текста

define(`COLOR', `
  DECLARE(`CONSOLE_$1')
      body(WUI(COLOR_$1))
    RUS SUMMARY(( -i) кладёт цвет $1)
')
COLOR(WHITE)
COLOR(BLACK)
COLOR(GRAY)
COLOR(RED)
COLOR(GREEN)
COLOR(BLUE)
COLOR(YELLOW)
COLOR(PINK)
COLOR(CYAN)
COLOR(LIGHTGRAY)
COLOR(LIGHTRED)
COLOR(LIGHTGREEN)
COLOR(LIGHTBLUE)
COLOR(LIGHTYELLOW)
COLOR(LIGHTPINK)
COLOR(LIGHTCYAN)
COLOR(DARKGRAY)
COLOR(DARKRED)
COLOR(DARKGREEN)
COLOR(DARKBLUE)
COLOR(DARKYELLOW)
COLOR(DARKPINK)
COLOR(DARKCYAN)
