unit ;

interface

uses
  ;

implementation

procedure RunCommand(Machine: TForthMachine; Command: PForthCommand); register;

// + - (EDX:=WP)
// sub EDX, 8
// mov EAX, [EDX + 4]
// add EAX, [EDX]
// sub EAX, [EDX - 4]
// mov [EDX - 4], EAX

// + 
// sub EDX, 4
// add EAX, [EDX]

// -
// sub EDX, 4
// sub EAX, [EDX]

// * 
// sub EDX, 4
// mul EAX, [EDX]

// div
// sub EDX, 4
// div EAX, [EDX]

// =
// 1)
// sub EDX, 4 
// cmp EAX, [EDX]
// if = then 
//    xor EAX, EAX
//    dec EAX
// else 
//    xor EAX, EAX
// 2)
// sub EDX, 4
// xor EAX, [EDX]
// ...

// swap
// mov EBX, [EDX-4]
// mov [EDX-4], EAX
// mov EAX, EBX

// over
// mov [EDX], EAX
// mov EAX, [EDX-4]
// add EDX, 4

// dup
// mov [EDX], EAX
// add EDX, 4

// tuck
// mov EBX, [EDX-4]
// mov [EDX-4], EAX
// mov [EDX+4], EAX
// mov [EDX], EBX
// add EDX, 4

// 1+
// inc EAX

// ?dup
// mov [EDX], EAX
// ??? if 0= then inc EDX, 4

// false или 0
// mov [EDX], EAX
// xor EAX, EAX
// inc EDX, 4

// true или -1
// mov [EDX], EAX
// xor EAX, EAX
// dec EAX
// inc EDX, 4

end.
