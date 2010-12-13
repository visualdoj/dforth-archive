// fpc -al -Sd Callback.pp
library Callback;

type
  TCallback = function (X, Y, Z, W: Integer): Integer; stdcall;

procedure Loop(Callback: TCallback); stdcall;
var
  R: Integer;
begin
  Writeln('Loop! ', Cardinal(@Callback));
  R := Callback( 1,  2,  3,  4);
  Writeln('Callback( 1,  2,  3,  4) = ', R);
  (* Callback(Callback( 1,  2,  3,  4),  *)
  (*          Callback( 5,  6,  7,  8),  *)
  (*          Callback( 9, 10, 11, 12),  *)
  (*          Callback(13, 14, 15, 16)); *)
end;

exports
  Loop;

end.
