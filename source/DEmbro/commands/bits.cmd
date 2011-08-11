DECLARE(false)
  begin
    with Machine^ do begin
      Machine.WUI(BOOL_FALSE);
    end;
  end;

DECLARE(true)
  begin
    with Machine^ do begin
      Machine.WUI(BOOL_TRUE);
    end;
  end;

DECLARE(not)
  begin
    with Machine^ do begin
      Machine.WUI(not Machine.WOI);
    end;
  end;

DECLARE(or)
  begin
    with Machine^ do begin
      Machine.WUI(Machine.WOI or Machine.WOI);
    end;
  end;

DECLARE(and)
  begin
    with Machine^ do begin
      Machine.WUI(Machine.WOI and Machine.WOI);
    end;
  end;

DECLARE(xor)
  begin
    with Machine^ do begin
      Machine.WUI(Machine.WOI xor Machine.WOI);
    end;
  end;

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
