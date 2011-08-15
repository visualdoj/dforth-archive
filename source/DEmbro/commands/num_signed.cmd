dnl DCommandsSignedArithmetic.pas4
define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
define(`signed_arithmetic_commands', `
    DECLARE(genname($1, abs), $1_abs) 
      body( $2(WVar(-SizeOf($2))) := Abs($2(WVar(-SizeOf($2)))); )
    DECLARE(genname($1, neg), $1_neg) 
      body( $2(WVar(-SizeOf($2))) := - $2(WVar(-SizeOf($2))); )
')

signed_arithmetic_commands(`', TInt)
signed_arithmetic_commands(int, TInt)
signed_arithmetic_commands(int8, TInt8)
signed_arithmetic_commands(int16, TInt16)
signed_arithmetic_commands(int32, TInt32)
signed_arithmetic_commands(int64, TInt64)
signed_arithmetic_commands(float, Single)
signed_arithmetic_commands(double, Double)
