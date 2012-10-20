DECLARE(cr)
  begin
    with Machine^ do begin
      Writeln;
    end;
  end;
RUS SUMMARY начинает новую строку _SUMMARY

DECLARE(emit)
  var
    I: Integer;
  begin
    with Machine^ do begin
      //Machine.Stack.Pop(@I, SizeOf(I));
      Write(Char(WOI));
    end;
  end;
RUS SUMMARY ( i) выводит символ с заданным номером _SUMMARY

DECLARE(space)
  begin
    with Machine^ do begin
      Write(' ');
    end;
  end;
RUS SUMMARY выводит пробел _SUMMARY

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
RUS SUMMARY ( i) выводит заданное число пробелов _SUMMARY

DECLARE(clear)
    body(Console.Clear(WOI);)
  RUS SUMMARY ( i) стирает i последних символов _SUMMARY

DECLARE(clear-line, clear_line)
    body(Console.ClearLine;)
  RUS SUMMARY стирает текущую линию _SUMMARY

DECLARE(clear-screen, clear_screen)
    body(Console.ClearScreen;)
  RUS SUMMARY стирает все символы экрана _SUMMARY

DECLARE(set-font-color, set_font_color)
    body(Console.SetFontColor(WOI);)
  RUS SUMMARY ( i) устанавливает i как цвет выводимого далее текста _SUMMARY

DECLARE(set-background-color, set_background_color)
    body(Console.SetBackgroundColor(WOI);)
  RUS SUMMARY ( i) устанавливает i как цвет выводимого фона для текста _SUMMARY

DECLARE(set-blink, set_blink)
    body()
  RUS SUMMARY ( f) устанавливает флаг мигания выводимого далее текста _SUMMARY

DECLARE(flush)
  body(Flush(Output))
  RUS SUMMARY ( ) принудительно выводит текст на консоль _SUMMARY

define(`COLOR', `
  DECLARE(`CONSOLE_$1')
      body(WUI(COLOR_$1))
    RUS SUMMARY(( -i) кладёт цвет $1) _SUMMARY
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
