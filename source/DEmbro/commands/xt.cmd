DECLARE(xt.n@, xt_dot_n)
    body(
      Pointer(WVar(-SizeOf(Pointer))) := @(PForthCommand(WVar(-SizeOf(Pointer))).Name[0]);)

DECLARE(xt.d@, xt_dot_d)
    body(
      Pointer(WVar(-SizeOf(Pointer))) := PForthCommand(WVar(-SizeOf(Pointer))).Data)
