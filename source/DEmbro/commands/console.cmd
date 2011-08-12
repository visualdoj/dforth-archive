DECLARE(cr)
  begin
    with Machine^ do begin
      Writeln;
    end;
  end;

DECLARE(emit)
  var
    I: Integer;
  begin
    with Machine^ do begin
      //Machine.Stack.Pop(@I, SizeOf(I));
      Write(Char(WOI));
    end;
  end;

DECLARE(space)
  begin
    with Machine^ do begin
      Write(' ');
    end;
  end;

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
