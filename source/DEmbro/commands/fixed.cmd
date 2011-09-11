DECLARE(byte!, byte_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TInt8(P^) := WOI;)

DECLARE(word!, word_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TInt16(P^) := WOI;)

DECLARE(dword!, dword_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TInt32(P^) := WOI;)

DECLARE(qword!, qword_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TInt64(P^) := WOI;)

DECLARE(ubyte!, ubyte_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TUInt8(P^) := WOU;)

DECLARE(uword!, uword_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TUInt16(P^) := WOU;)

DECLARE(udword!, udword_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TUInt32(P^) := WOU;)

DECLARE(uqword!, uqword_ex)
  var
    P: Pointer;
  body(
    P := WOP;
    TUInt64(P^) := WOU;)

DECLARE(byte@, byte_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUI(TInt8(P^));)

DECLARE(word@, word_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUI(TInt16(P^));)

DECLARE(dword@, dword_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUI(TInt32(P^));)

DECLARE(qword@, qword_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUI(TInt64(P^));)

DECLARE(ubyte@, ubyte_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUU(TUInt8(P^));)

DECLARE(uword@, uword_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUU(TUInt16(P^));)

DECLARE(udword@, udword_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUU(TUInt32(P^));)

DECLARE(uqword@, uqword_dog)
  var
    P: Pointer;
  body(
    P := WOP;
    WUU(TUInt64(P^));)
