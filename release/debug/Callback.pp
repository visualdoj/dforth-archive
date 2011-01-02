// fpc -al -Sd Callback.pp
library Callback;

type
  TCallback = function (X, Y, Z, W: Integer): Integer; stdcall;

procedure Loop(Callback: TCallback); stdcall;
var
  R: Integer;
begin
  // Writeln('Loop! ', Cardinal(@Callback));
  R := Callback( 1001,  2002,  3003,  4004);
  Writeln('Callback( 1001,  2002,  3003,  4004) = ', R);
  (* Callback(Callback( 1,  2,  3,  4),  *)
  (*          Callback( 5,  6,  7,  8),  *)
  (*          Callback( 9, 10, 11, 12),  *)
  (*          Callback(13, 14, 15, 16)); *)
end;

procedure Loop2(Callback: TCallback; A, B, C, D: Integer); stdcall;
var
  R: Integer;
begin
  Writeln('Loop! ', Cardinal(@Callback));
  R := Callback(A, B, C, D);
  Writeln('Callback(', A, ', ', B, ', ', C, ', ', D, ') = ', R);
  (* Callback(Callback( 1,  2,  3,  4),  *)
  (*          Callback( 5,  6,  7,  8),  *)
  (*          Callback( 9, 10, 11, 12),  *)
  (*          Callback(13, 14, 15, 16)); *)
end;

exports
  Loop,
  Loop2;

end.
