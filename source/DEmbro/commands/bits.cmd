DECLARE(false)
  begin
    with Machine^ do begin
      Machine.WUI(BOOL_FALSE);
    end;
  end;
RUS SUMMARY ( -i) кладёт ячейку со всеми битами установленными в 0 _SUMMARY

DECLARE(true)
  begin
    with Machine^ do begin
      Machine.WUI(BOOL_TRUE);
    end;
  end;
RUS SUMMARY ( -i) кладёт ячейку со всеми битами установленными в 1 _SUMMARY

DECLARE(not)
  begin
    with Machine^ do begin
      Machine.WUI(not Machine.WOI);
    end;
  end;
RUS SUMMARY ( i-i) обращают все биты вырхней ячейки стека _SUMMARY

DECLARE(or)
  begin
    with Machine^ do begin
      Machine.WUI(Machine.WOI or Machine.WOI);
    end;
  end;
RUS SUMMARY ( ii-i) применяет операцию ИЛИ к каждому биту двух верхних элементов стека _SUMMARY

DECLARE(and)
  begin
    with Machine^ do begin
      Machine.WUI(Machine.WOI and Machine.WOI);
    end;
  end;
RUS SUMMARY ( ii-i) применяет операцию И к каждому биту двух верхних элементов стека _SUMMARY

DECLARE(xor)
  begin
    with Machine^ do begin
      Machine.WUU(Machine.WOU xor Machine.WOU);
    end;
  end;
RUS SUMMARY ( ii-i) применяет операцию исключающее ИЛИ к каждому биту двух верхних элементов стека _SUMMARY

DECLARE(bool., bool_dot)
  var
    a: TInt;
  begin
    with Machine^ do begin
      a := Machine.WOI;
      if a = 0 then
        Write('FALSE ')
      else
        Write('TRUE ')
    end;
  end;
RUS SUMMARY ( ?-) печатает TRUE, если ячейка на стеке ненулевая, и FALSE иначе _SUMMARY

DECLARE(bool-false, bool_false)
  body(_false(Machine, Command);)
DECLARE(bool-true, bool_true)
  body(_true(Machine, Command);)
DECLARE(bool-not, bool_not)
  body(_not(Machine, Command);)
DECLARE(bool-or, bool_or)
  body(_or(Machine, Command);)
DECLARE(bool-and, bool_and)
  body(_and(Machine, Command);)
DECLARE(bool-xor, bool_xor)
  body(_xor(Machine, Command);)
