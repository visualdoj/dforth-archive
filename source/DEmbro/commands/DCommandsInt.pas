


















unit DCommandsInt;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DForthMachine;




























{$IFNDEF FLAG_FPC}{$REGION 'typed_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

  
    procedure drop_ (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_ (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_ (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_ (Machine: TForthMachine; Command: PForthCommand);
    procedure over_ (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_ (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_ (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_ (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_ (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_ (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure over_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_ptr (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure over_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_embro (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_float (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_float (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_float (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_float (Machine: TForthMachine; Command: PForthCommand);
    procedure over_float (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_float (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_float (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_float (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_float (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_float (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_float (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_float (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_float (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_float (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_double (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_double (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_double (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_double (Machine: TForthMachine; Command: PForthCommand);
    procedure over_double (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_double (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_double (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_double (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_double (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_double (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_double (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_double (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_double (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_double (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure over_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;

procedure LoadCommands(Machine: TForthMachine);

implementation

 
    
     
         procedure drop_ (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_ (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_ (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_ (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_ (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_ (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_ (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_ (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_ (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_ (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_ (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWI(Integer(WP^))  end; end;
     procedure _dog_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_(Machine, Command) else _interpret_to_(Machine, Command);  end; end;
     procedure _compile_to_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@to'); EWO(NextName);  end; end;
     procedure _run_to_ (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_ (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('(literal)'); Dec(WP, 4); 
                                       EWI(Integer(WP^))  end; end;
    procedure run_literal_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_ptr (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_ptr (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_ptr(Machine, Command) else _interpret_to_ptr(Machine, Command);  end; end;
     procedure _compile_to_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@ptr-to'); EWO(NextName);  end; end;
     procedure _run_to_ptr (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_ptr (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after ptr-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_ptr; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('ptr-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_int (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_int (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_int (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_int (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int(Machine, Command) else _interpret_to_int(Machine, Command);  end; end;
     procedure _compile_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int-to'); EWO(NextName);  end; end;
     procedure _run_to_int (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_int (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1); Inc(WP, 1);  end; end;
         procedure nip_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
      end; end;
     procedure rrot_int8 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
      end; end;
     procedure lrotn_int8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-1*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-1*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-1))^), 1);
      end; end;
     procedure rrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-1*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*1))^), 1);
      end; end;
     procedure pick_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
      end; end;
     procedure _comma_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 1); EWV(WP, 1);   end; end;
     procedure _dog_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1)  end; end;
     procedure ptr_plus_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 1;  end; end;
     procedure _to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int8(Machine, Command) else _interpret_to_int8(Machine, Command);  end; end;
     procedure _compile_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int8-to'); EWO(NextName);  end; end;
     procedure _run_to_int8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1);  end; end;
     procedure _interpret_to_int8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-1))^), Comm.Data^, 1); Dec(WP, 1);
              end; end;
     procedure _value_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int8; Move((Pointer(TUInt(Machine.WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end;  end; end;
     procedure RunValue_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 1); Inc(WP, 1);  end; end;
    procedure literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int8-(literal)'); Dec(WP, 1); 
                                       EWV(WP, 1);  end; end;
    procedure run_literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 1); Inc(WP, 1);  end; end;
    
   
    
     
         procedure drop_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2); Inc(WP, 2);  end; end;
         procedure nip_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
      end; end;
     procedure rrot_int16 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
      end; end;
     procedure lrotn_int16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-2*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-2*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-2))^), 2);
      end; end;
     procedure rrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-2*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*2))^), 2);
      end; end;
     procedure pick_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
      end; end;
     procedure _comma_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 2); EWV(WP, 2);   end; end;
     procedure _dog_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2)  end; end;
     procedure ptr_plus_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 2;  end; end;
     procedure _to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int16(Machine, Command) else _interpret_to_int16(Machine, Command);  end; end;
     procedure _compile_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int16-to'); EWO(NextName);  end; end;
     procedure _run_to_int16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2);  end; end;
     procedure _interpret_to_int16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-2))^), Comm.Data^, 2); Dec(WP, 2);
              end; end;
     procedure _value_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int16; Move((Pointer(TUInt(Machine.WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end;  end; end;
     procedure RunValue_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 2); Inc(WP, 2);  end; end;
    procedure literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int16-(literal)'); Dec(WP, 2); 
                                       EWV(WP, 2);  end; end;
    procedure run_literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 2); Inc(WP, 2);  end; end;
    
   
    
     
         procedure drop_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_int32 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_int32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int32(Machine, Command) else _interpret_to_int32(Machine, Command);  end; end;
     procedure _compile_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int32-to'); EWO(NextName);  end; end;
     procedure _run_to_int32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_int32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int32; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int32-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_int64 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_int64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int64(Machine, Command) else _interpret_to_int64(Machine, Command);  end; end;
     procedure _compile_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int64-to'); EWO(NextName);  end; end;
     procedure _run_to_int64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_int64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int64; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int64-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_uint (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_uint (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_uint (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint(Machine, Command) else _interpret_to_uint(Machine, Command);  end; end;
     procedure _compile_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint-to'); EWO(NextName);  end; end;
     procedure _run_to_uint (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_uint (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1); Inc(WP, 1);  end; end;
         procedure nip_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
      end; end;
     procedure rrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
      end; end;
     procedure lrotn_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-1*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-1*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-1))^), 1);
      end; end;
     procedure rrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-1*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*1))^), 1);
      end; end;
     procedure pick_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
      end; end;
     procedure _comma_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 1); EWV(WP, 1);   end; end;
     procedure _dog_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1)  end; end;
     procedure ptr_plus_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 1;  end; end;
     procedure _to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint8(Machine, Command) else _interpret_to_uint8(Machine, Command);  end; end;
     procedure _compile_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint8-to'); EWO(NextName);  end; end;
     procedure _run_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1);  end; end;
     procedure _interpret_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-1))^), Comm.Data^, 1); Dec(WP, 1);
              end; end;
     procedure _value_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint8; Move((Pointer(TUInt(Machine.WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end;  end; end;
     procedure RunValue_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 1); Inc(WP, 1);  end; end;
    procedure literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint8-(literal)'); Dec(WP, 1); 
                                       EWV(WP, 1);  end; end;
    procedure run_literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 1); Inc(WP, 1);  end; end;
    
   
    
     
         procedure drop_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2); Inc(WP, 2);  end; end;
         procedure nip_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
      end; end;
     procedure rrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
      end; end;
     procedure lrotn_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-2*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-2*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-2))^), 2);
      end; end;
     procedure rrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-2*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*2))^), 2);
      end; end;
     procedure pick_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
      end; end;
     procedure _comma_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 2); EWV(WP, 2);   end; end;
     procedure _dog_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2)  end; end;
     procedure ptr_plus_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 2;  end; end;
     procedure _to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint16(Machine, Command) else _interpret_to_uint16(Machine, Command);  end; end;
     procedure _compile_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint16-to'); EWO(NextName);  end; end;
     procedure _run_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2);  end; end;
     procedure _interpret_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-2))^), Comm.Data^, 2); Dec(WP, 2);
              end; end;
     procedure _value_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint16; Move((Pointer(TUInt(Machine.WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end;  end; end;
     procedure RunValue_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 2); Inc(WP, 2);  end; end;
    procedure literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint16-(literal)'); Dec(WP, 2); 
                                       EWV(WP, 2);  end; end;
    procedure run_literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 2); Inc(WP, 2);  end; end;
    
   
    
     
         procedure drop_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint32(Machine, Command) else _interpret_to_uint32(Machine, Command);  end; end;
     procedure _compile_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint32-to'); EWO(NextName);  end; end;
     procedure _run_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint32; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint32-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint64(Machine, Command) else _interpret_to_uint64(Machine, Command);  end; end;
     procedure _compile_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint64-to'); EWO(NextName);  end; end;
     procedure _run_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint64; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint64-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_embro (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_embro (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_embro (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_embro (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_embro(Machine, Command) else _interpret_to_embro(Machine, Command);  end; end;
     procedure _compile_to_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@embro-to'); EWO(NextName);  end; end;
     procedure _run_to_embro (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_embro (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after embro-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_embro; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('embro-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_float (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_float (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_float (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_float (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_float (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_float (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_float(Machine, Command) else _interpret_to_float(Machine, Command);  end; end;
     procedure _compile_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@float-to'); EWO(NextName);  end; end;
     procedure _run_to_float (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_float (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after float-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_float; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('float-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_double (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_double (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_double (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_double (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_double (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_double (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_double(Machine, Command) else _interpret_to_double(Machine, Command);  end; end;
     procedure _compile_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@double-to'); EWO(NextName);  end; end;
     procedure _run_to_double (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_double (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after double-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_double; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('double-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-10))^), (Pointer(TUInt(Machine.WP) + (0))^), 10); Inc(WP, 10);  end; end;
         procedure nip_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_extended (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_extended (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*10))^), WP^, 10);
       Move((Pointer(TUInt(Machine.WP) + (-3*10))^), (Pointer(TUInt(Machine.WP) + (-1*10))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (-2*10))^), (Pointer(TUInt(Machine.WP) + (-3*10))^), 10);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*10))^), 10);
      end; end;
     procedure rrot_extended (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*10))^), WP^, 10);
       Move((Pointer(TUInt(Machine.WP) + (-2*10))^), (Pointer(TUInt(Machine.WP) + (-1*10))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (-3*10))^), (Pointer(TUInt(Machine.WP) + (-2*10))^), 10);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*10))^), 10);
      end; end;
     procedure lrotn_extended (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-10*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 10);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-10*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-10*N))^), 10);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-10))^), 10);
      end; end;
     procedure rrotn_extended (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-10))^), (Pointer(TUInt(Machine.WP) + (0))^), 10);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-10*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-10*I))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*10))^), 10);
      end; end;
     procedure pick_extended (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -10*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            10);
       Inc(WP, 10 - SizeOf(TInt));
      end; end;
     procedure _comma_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 10); EWV(WP, 10);   end; end;
     procedure _dog_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 10); Inc(WP, 10 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-10))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 10); Dec(WP, (SizeOf(Pointer)) + 10)  end; end;
     procedure ptr_plus_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 10;  end; end;
     procedure _to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_extended(Machine, Command) else _interpret_to_extended(Machine, Command);  end; end;
     procedure _compile_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@extended-to'); EWO(NextName);  end; end;
     procedure _run_to_extended (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-10))^), C[O].Data^, 10); Dec(WP, 10);  end; end;
     procedure _interpret_to_extended (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after extended-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-10))^), Comm.Data^, 10); Dec(WP, 10);
              end; end;
     procedure _value_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_extended; Move((Pointer(TUInt(Machine.WP) + (-10))^), Here^, 10); Dec(WP, 10); EA(10); Flags := Flags and not 1; end;  end; end;
     procedure _variable_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 10); Move(WP^, Here^, 10);} EA(10); end;  end; end;
     procedure RunValue_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 10); Inc(WP, 10);  end; end;
    procedure literal_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('extended-(literal)'); Dec(WP, 10); 
                                       EWV(WP, 10);  end; end;
    procedure run_literal_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 10); Inc(WP, 10);  end; end;
    
  

procedure LoadCommands(Machine: TForthMachine);
begin
  
    
     Machine.AddCommand('drop', drop_);
     Machine.AddCommand('dup', dup_);
     Machine.AddCommand('nip', nip_);
     Machine.AddCommand('swap', swap_);
     Machine.AddCommand('over', over_);
     Machine.AddCommand('tuck', tuck_);
     Machine.AddCommand('lrot', lrot_);
     Machine.AddCommand('rrot', rrot_);
     Machine.AddCommand('lrotn', lrotn_);
     Machine.AddCommand('rrotn', rrotn_);
     Machine.AddCommand('pick', pick_);
     Machine.AddCommand(',', _comma_);
     Machine.AddCommand('@', _dog_);
     Machine.AddCommand('!', _exclamation_);
     Machine.AddCommand('ptr+', ptr_plus_);
     Machine.AddCommand('to', _to_, True);
     Machine.AddCommand('compile@to', _compile_to_);
     Machine.AddCommand('run@to', _run_to_);
     Machine.AddCommand('interpret@to', _interpret_to_);
     Machine.AddCommand('value', _value_);
     Machine.AddCommand('constant', _value_);
     Machine.AddCommand('variable', _variable_);
     Machine.AddCommand('literal', literal_, True);
     Machine.AddCommand('(literal)', run_literal_);
    
    
     Machine.AddCommand('ptr-drop', drop_ptr);
     Machine.AddCommand('ptr-dup', dup_ptr);
     Machine.AddCommand('ptr-nip', nip_ptr);
     Machine.AddCommand('ptr-swap', swap_ptr);
     Machine.AddCommand('ptr-over', over_ptr);
     Machine.AddCommand('ptr-tuck', tuck_ptr);
     Machine.AddCommand('ptr-lrot', lrot_ptr);
     Machine.AddCommand('ptr-rrot', rrot_ptr);
     Machine.AddCommand('ptr-lrotn', lrotn_ptr);
     Machine.AddCommand('ptr-rrotn', rrotn_ptr);
     Machine.AddCommand('ptr-pick', pick_ptr);
     Machine.AddCommand('ptr,', _comma_ptr);
     Machine.AddCommand('ptr@', _dog_ptr);
     Machine.AddCommand('ptr!', _exclamation_ptr);
     Machine.AddCommand('ptr+ptr', ptr_plus_ptr);
     Machine.AddCommand('ptr-to', _to_ptr, True);
     Machine.AddCommand('compile@ptr-to', _compile_to_ptr);
     Machine.AddCommand('run@ptr-to', _run_to_ptr);
     Machine.AddCommand('interpret@ptr-to', _interpret_to_ptr);
     Machine.AddCommand('ptr-value', _value_ptr);
     Machine.AddCommand('ptr-constant', _value_ptr);
     Machine.AddCommand('ptr-variable', _variable_ptr);
     Machine.AddCommand('ptr-literal', literal_ptr, True);
     Machine.AddCommand('ptr-(literal)', run_literal_ptr);
    
    
     Machine.AddCommand('int-drop', drop_int);
     Machine.AddCommand('int-dup', dup_int);
     Machine.AddCommand('int-nip', nip_int);
     Machine.AddCommand('int-swap', swap_int);
     Machine.AddCommand('int-over', over_int);
     Machine.AddCommand('int-tuck', tuck_int);
     Machine.AddCommand('int-lrot', lrot_int);
     Machine.AddCommand('int-rrot', rrot_int);
     Machine.AddCommand('int-lrotn', lrotn_int);
     Machine.AddCommand('int-rrotn', rrotn_int);
     Machine.AddCommand('int-pick', pick_int);
     Machine.AddCommand('int,', _comma_int);
     Machine.AddCommand('int@', _dog_int);
     Machine.AddCommand('int!', _exclamation_int);
     Machine.AddCommand('ptr+int', ptr_plus_int);
     Machine.AddCommand('int-to', _to_int, True);
     Machine.AddCommand('compile@int-to', _compile_to_int);
     Machine.AddCommand('run@int-to', _run_to_int);
     Machine.AddCommand('interpret@int-to', _interpret_to_int);
     Machine.AddCommand('int-value', _value_int);
     Machine.AddCommand('int-constant', _value_int);
     Machine.AddCommand('int-variable', _variable_int);
     Machine.AddCommand('int-literal', literal_int, True);
     Machine.AddCommand('int-(literal)', run_literal_int);
    
    
     Machine.AddCommand('int8-drop', drop_int8);
     Machine.AddCommand('int8-dup', dup_int8);
     Machine.AddCommand('int8-nip', nip_int8);
     Machine.AddCommand('int8-swap', swap_int8);
     Machine.AddCommand('int8-over', over_int8);
     Machine.AddCommand('int8-tuck', tuck_int8);
     Machine.AddCommand('int8-lrot', lrot_int8);
     Machine.AddCommand('int8-rrot', rrot_int8);
     Machine.AddCommand('int8-lrotn', lrotn_int8);
     Machine.AddCommand('int8-rrotn', rrotn_int8);
     Machine.AddCommand('int8-pick', pick_int8);
     Machine.AddCommand('int8,', _comma_int8);
     Machine.AddCommand('int8@', _dog_int8);
     Machine.AddCommand('int8!', _exclamation_int8);
     Machine.AddCommand('ptr+int8', ptr_plus_int8);
     Machine.AddCommand('int8-to', _to_int8, True);
     Machine.AddCommand('compile@int8-to', _compile_to_int8);
     Machine.AddCommand('run@int8-to', _run_to_int8);
     Machine.AddCommand('interpret@int8-to', _interpret_to_int8);
     Machine.AddCommand('int8-value', _value_int8);
     Machine.AddCommand('int8-constant', _value_int8);
     Machine.AddCommand('int8-variable', _variable_int8);
     Machine.AddCommand('int8-literal', literal_int8, True);
     Machine.AddCommand('int8-(literal)', run_literal_int8);
    
    
     Machine.AddCommand('int16-drop', drop_int16);
     Machine.AddCommand('int16-dup', dup_int16);
     Machine.AddCommand('int16-nip', nip_int16);
     Machine.AddCommand('int16-swap', swap_int16);
     Machine.AddCommand('int16-over', over_int16);
     Machine.AddCommand('int16-tuck', tuck_int16);
     Machine.AddCommand('int16-lrot', lrot_int16);
     Machine.AddCommand('int16-rrot', rrot_int16);
     Machine.AddCommand('int16-lrotn', lrotn_int16);
     Machine.AddCommand('int16-rrotn', rrotn_int16);
     Machine.AddCommand('int16-pick', pick_int16);
     Machine.AddCommand('int16,', _comma_int16);
     Machine.AddCommand('int16@', _dog_int16);
     Machine.AddCommand('int16!', _exclamation_int16);
     Machine.AddCommand('ptr+int16', ptr_plus_int16);
     Machine.AddCommand('int16-to', _to_int16, True);
     Machine.AddCommand('compile@int16-to', _compile_to_int16);
     Machine.AddCommand('run@int16-to', _run_to_int16);
     Machine.AddCommand('interpret@int16-to', _interpret_to_int16);
     Machine.AddCommand('int16-value', _value_int16);
     Machine.AddCommand('int16-constant', _value_int16);
     Machine.AddCommand('int16-variable', _variable_int16);
     Machine.AddCommand('int16-literal', literal_int16, True);
     Machine.AddCommand('int16-(literal)', run_literal_int16);
    
    
     Machine.AddCommand('int32-drop', drop_int32);
     Machine.AddCommand('int32-dup', dup_int32);
     Machine.AddCommand('int32-nip', nip_int32);
     Machine.AddCommand('int32-swap', swap_int32);
     Machine.AddCommand('int32-over', over_int32);
     Machine.AddCommand('int32-tuck', tuck_int32);
     Machine.AddCommand('int32-lrot', lrot_int32);
     Machine.AddCommand('int32-rrot', rrot_int32);
     Machine.AddCommand('int32-lrotn', lrotn_int32);
     Machine.AddCommand('int32-rrotn', rrotn_int32);
     Machine.AddCommand('int32-pick', pick_int32);
     Machine.AddCommand('int32,', _comma_int32);
     Machine.AddCommand('int32@', _dog_int32);
     Machine.AddCommand('int32!', _exclamation_int32);
     Machine.AddCommand('ptr+int32', ptr_plus_int32);
     Machine.AddCommand('int32-to', _to_int32, True);
     Machine.AddCommand('compile@int32-to', _compile_to_int32);
     Machine.AddCommand('run@int32-to', _run_to_int32);
     Machine.AddCommand('interpret@int32-to', _interpret_to_int32);
     Machine.AddCommand('int32-value', _value_int32);
     Machine.AddCommand('int32-constant', _value_int32);
     Machine.AddCommand('int32-variable', _variable_int32);
     Machine.AddCommand('int32-literal', literal_int32, True);
     Machine.AddCommand('int32-(literal)', run_literal_int32);
    
    
     Machine.AddCommand('int64-drop', drop_int64);
     Machine.AddCommand('int64-dup', dup_int64);
     Machine.AddCommand('int64-nip', nip_int64);
     Machine.AddCommand('int64-swap', swap_int64);
     Machine.AddCommand('int64-over', over_int64);
     Machine.AddCommand('int64-tuck', tuck_int64);
     Machine.AddCommand('int64-lrot', lrot_int64);
     Machine.AddCommand('int64-rrot', rrot_int64);
     Machine.AddCommand('int64-lrotn', lrotn_int64);
     Machine.AddCommand('int64-rrotn', rrotn_int64);
     Machine.AddCommand('int64-pick', pick_int64);
     Machine.AddCommand('int64,', _comma_int64);
     Machine.AddCommand('int64@', _dog_int64);
     Machine.AddCommand('int64!', _exclamation_int64);
     Machine.AddCommand('ptr+int64', ptr_plus_int64);
     Machine.AddCommand('int64-to', _to_int64, True);
     Machine.AddCommand('compile@int64-to', _compile_to_int64);
     Machine.AddCommand('run@int64-to', _run_to_int64);
     Machine.AddCommand('interpret@int64-to', _interpret_to_int64);
     Machine.AddCommand('int64-value', _value_int64);
     Machine.AddCommand('int64-constant', _value_int64);
     Machine.AddCommand('int64-variable', _variable_int64);
     Machine.AddCommand('int64-literal', literal_int64, True);
     Machine.AddCommand('int64-(literal)', run_literal_int64);
    
    
     Machine.AddCommand('uint-drop', drop_uint);
     Machine.AddCommand('uint-dup', dup_uint);
     Machine.AddCommand('uint-nip', nip_uint);
     Machine.AddCommand('uint-swap', swap_uint);
     Machine.AddCommand('uint-over', over_uint);
     Machine.AddCommand('uint-tuck', tuck_uint);
     Machine.AddCommand('uint-lrot', lrot_uint);
     Machine.AddCommand('uint-rrot', rrot_uint);
     Machine.AddCommand('uint-lrotn', lrotn_uint);
     Machine.AddCommand('uint-rrotn', rrotn_uint);
     Machine.AddCommand('uint-pick', pick_uint);
     Machine.AddCommand('uint,', _comma_uint);
     Machine.AddCommand('uint@', _dog_uint);
     Machine.AddCommand('uint!', _exclamation_uint);
     Machine.AddCommand('ptr+uint', ptr_plus_uint);
     Machine.AddCommand('uint-to', _to_uint, True);
     Machine.AddCommand('compile@uint-to', _compile_to_uint);
     Machine.AddCommand('run@uint-to', _run_to_uint);
     Machine.AddCommand('interpret@uint-to', _interpret_to_uint);
     Machine.AddCommand('uint-value', _value_uint);
     Machine.AddCommand('uint-constant', _value_uint);
     Machine.AddCommand('uint-variable', _variable_uint);
     Machine.AddCommand('uint-literal', literal_uint, True);
     Machine.AddCommand('uint-(literal)', run_literal_uint);
    
    
     Machine.AddCommand('uint8-drop', drop_uint8);
     Machine.AddCommand('uint8-dup', dup_uint8);
     Machine.AddCommand('uint8-nip', nip_uint8);
     Machine.AddCommand('uint8-swap', swap_uint8);
     Machine.AddCommand('uint8-over', over_uint8);
     Machine.AddCommand('uint8-tuck', tuck_uint8);
     Machine.AddCommand('uint8-lrot', lrot_uint8);
     Machine.AddCommand('uint8-rrot', rrot_uint8);
     Machine.AddCommand('uint8-lrotn', lrotn_uint8);
     Machine.AddCommand('uint8-rrotn', rrotn_uint8);
     Machine.AddCommand('uint8-pick', pick_uint8);
     Machine.AddCommand('uint8,', _comma_uint8);
     Machine.AddCommand('uint8@', _dog_uint8);
     Machine.AddCommand('uint8!', _exclamation_uint8);
     Machine.AddCommand('ptr+uint8', ptr_plus_uint8);
     Machine.AddCommand('uint8-to', _to_uint8, True);
     Machine.AddCommand('compile@uint8-to', _compile_to_uint8);
     Machine.AddCommand('run@uint8-to', _run_to_uint8);
     Machine.AddCommand('interpret@uint8-to', _interpret_to_uint8);
     Machine.AddCommand('uint8-value', _value_uint8);
     Machine.AddCommand('uint8-constant', _value_uint8);
     Machine.AddCommand('uint8-variable', _variable_uint8);
     Machine.AddCommand('uint8-literal', literal_uint8, True);
     Machine.AddCommand('uint8-(literal)', run_literal_uint8);
    
    
     Machine.AddCommand('uint16-drop', drop_uint16);
     Machine.AddCommand('uint16-dup', dup_uint16);
     Machine.AddCommand('uint16-nip', nip_uint16);
     Machine.AddCommand('uint16-swap', swap_uint16);
     Machine.AddCommand('uint16-over', over_uint16);
     Machine.AddCommand('uint16-tuck', tuck_uint16);
     Machine.AddCommand('uint16-lrot', lrot_uint16);
     Machine.AddCommand('uint16-rrot', rrot_uint16);
     Machine.AddCommand('uint16-lrotn', lrotn_uint16);
     Machine.AddCommand('uint16-rrotn', rrotn_uint16);
     Machine.AddCommand('uint16-pick', pick_uint16);
     Machine.AddCommand('uint16,', _comma_uint16);
     Machine.AddCommand('uint16@', _dog_uint16);
     Machine.AddCommand('uint16!', _exclamation_uint16);
     Machine.AddCommand('ptr+uint16', ptr_plus_uint16);
     Machine.AddCommand('uint16-to', _to_uint16, True);
     Machine.AddCommand('compile@uint16-to', _compile_to_uint16);
     Machine.AddCommand('run@uint16-to', _run_to_uint16);
     Machine.AddCommand('interpret@uint16-to', _interpret_to_uint16);
     Machine.AddCommand('uint16-value', _value_uint16);
     Machine.AddCommand('uint16-constant', _value_uint16);
     Machine.AddCommand('uint16-variable', _variable_uint16);
     Machine.AddCommand('uint16-literal', literal_uint16, True);
     Machine.AddCommand('uint16-(literal)', run_literal_uint16);
    
    
     Machine.AddCommand('uint32-drop', drop_uint32);
     Machine.AddCommand('uint32-dup', dup_uint32);
     Machine.AddCommand('uint32-nip', nip_uint32);
     Machine.AddCommand('uint32-swap', swap_uint32);
     Machine.AddCommand('uint32-over', over_uint32);
     Machine.AddCommand('uint32-tuck', tuck_uint32);
     Machine.AddCommand('uint32-lrot', lrot_uint32);
     Machine.AddCommand('uint32-rrot', rrot_uint32);
     Machine.AddCommand('uint32-lrotn', lrotn_uint32);
     Machine.AddCommand('uint32-rrotn', rrotn_uint32);
     Machine.AddCommand('uint32-pick', pick_uint32);
     Machine.AddCommand('uint32,', _comma_uint32);
     Machine.AddCommand('uint32@', _dog_uint32);
     Machine.AddCommand('uint32!', _exclamation_uint32);
     Machine.AddCommand('ptr+uint32', ptr_plus_uint32);
     Machine.AddCommand('uint32-to', _to_uint32, True);
     Machine.AddCommand('compile@uint32-to', _compile_to_uint32);
     Machine.AddCommand('run@uint32-to', _run_to_uint32);
     Machine.AddCommand('interpret@uint32-to', _interpret_to_uint32);
     Machine.AddCommand('uint32-value', _value_uint32);
     Machine.AddCommand('uint32-constant', _value_uint32);
     Machine.AddCommand('uint32-variable', _variable_uint32);
     Machine.AddCommand('uint32-literal', literal_uint32, True);
     Machine.AddCommand('uint32-(literal)', run_literal_uint32);
    
    
     Machine.AddCommand('uint64-drop', drop_uint64);
     Machine.AddCommand('uint64-dup', dup_uint64);
     Machine.AddCommand('uint64-nip', nip_uint64);
     Machine.AddCommand('uint64-swap', swap_uint64);
     Machine.AddCommand('uint64-over', over_uint64);
     Machine.AddCommand('uint64-tuck', tuck_uint64);
     Machine.AddCommand('uint64-lrot', lrot_uint64);
     Machine.AddCommand('uint64-rrot', rrot_uint64);
     Machine.AddCommand('uint64-lrotn', lrotn_uint64);
     Machine.AddCommand('uint64-rrotn', rrotn_uint64);
     Machine.AddCommand('uint64-pick', pick_uint64);
     Machine.AddCommand('uint64,', _comma_uint64);
     Machine.AddCommand('uint64@', _dog_uint64);
     Machine.AddCommand('uint64!', _exclamation_uint64);
     Machine.AddCommand('ptr+uint64', ptr_plus_uint64);
     Machine.AddCommand('uint64-to', _to_uint64, True);
     Machine.AddCommand('compile@uint64-to', _compile_to_uint64);
     Machine.AddCommand('run@uint64-to', _run_to_uint64);
     Machine.AddCommand('interpret@uint64-to', _interpret_to_uint64);
     Machine.AddCommand('uint64-value', _value_uint64);
     Machine.AddCommand('uint64-constant', _value_uint64);
     Machine.AddCommand('uint64-variable', _variable_uint64);
     Machine.AddCommand('uint64-literal', literal_uint64, True);
     Machine.AddCommand('uint64-(literal)', run_literal_uint64);
    
    
     Machine.AddCommand('embro-drop', drop_embro);
     Machine.AddCommand('embro-dup', dup_embro);
     Machine.AddCommand('embro-nip', nip_embro);
     Machine.AddCommand('embro-swap', swap_embro);
     Machine.AddCommand('embro-over', over_embro);
     Machine.AddCommand('embro-tuck', tuck_embro);
     Machine.AddCommand('embro-lrot', lrot_embro);
     Machine.AddCommand('embro-rrot', rrot_embro);
     Machine.AddCommand('embro-lrotn', lrotn_embro);
     Machine.AddCommand('embro-rrotn', rrotn_embro);
     Machine.AddCommand('embro-pick', pick_embro);
     Machine.AddCommand('embro,', _comma_embro);
     Machine.AddCommand('embro@', _dog_embro);
     Machine.AddCommand('embro!', _exclamation_embro);
     Machine.AddCommand('ptr+embro', ptr_plus_embro);
     Machine.AddCommand('embro-to', _to_embro, True);
     Machine.AddCommand('compile@embro-to', _compile_to_embro);
     Machine.AddCommand('run@embro-to', _run_to_embro);
     Machine.AddCommand('interpret@embro-to', _interpret_to_embro);
     Machine.AddCommand('embro-value', _value_embro);
     Machine.AddCommand('embro-constant', _value_embro);
     Machine.AddCommand('embro-variable', _variable_embro);
     Machine.AddCommand('embro-literal', literal_embro, True);
     Machine.AddCommand('embro-(literal)', run_literal_embro);
    
    
     Machine.AddCommand('float-drop', drop_float);
     Machine.AddCommand('float-dup', dup_float);
     Machine.AddCommand('float-nip', nip_float);
     Machine.AddCommand('float-swap', swap_float);
     Machine.AddCommand('float-over', over_float);
     Machine.AddCommand('float-tuck', tuck_float);
     Machine.AddCommand('float-lrot', lrot_float);
     Machine.AddCommand('float-rrot', rrot_float);
     Machine.AddCommand('float-lrotn', lrotn_float);
     Machine.AddCommand('float-rrotn', rrotn_float);
     Machine.AddCommand('float-pick', pick_float);
     Machine.AddCommand('float,', _comma_float);
     Machine.AddCommand('float@', _dog_float);
     Machine.AddCommand('float!', _exclamation_float);
     Machine.AddCommand('ptr+float', ptr_plus_float);
     Machine.AddCommand('float-to', _to_float, True);
     Machine.AddCommand('compile@float-to', _compile_to_float);
     Machine.AddCommand('run@float-to', _run_to_float);
     Machine.AddCommand('interpret@float-to', _interpret_to_float);
     Machine.AddCommand('float-value', _value_float);
     Machine.AddCommand('float-constant', _value_float);
     Machine.AddCommand('float-variable', _variable_float);
     Machine.AddCommand('float-literal', literal_float, True);
     Machine.AddCommand('float-(literal)', run_literal_float);
    
    
     Machine.AddCommand('double-drop', drop_double);
     Machine.AddCommand('double-dup', dup_double);
     Machine.AddCommand('double-nip', nip_double);
     Machine.AddCommand('double-swap', swap_double);
     Machine.AddCommand('double-over', over_double);
     Machine.AddCommand('double-tuck', tuck_double);
     Machine.AddCommand('double-lrot', lrot_double);
     Machine.AddCommand('double-rrot', rrot_double);
     Machine.AddCommand('double-lrotn', lrotn_double);
     Machine.AddCommand('double-rrotn', rrotn_double);
     Machine.AddCommand('double-pick', pick_double);
     Machine.AddCommand('double,', _comma_double);
     Machine.AddCommand('double@', _dog_double);
     Machine.AddCommand('double!', _exclamation_double);
     Machine.AddCommand('ptr+double', ptr_plus_double);
     Machine.AddCommand('double-to', _to_double, True);
     Machine.AddCommand('compile@double-to', _compile_to_double);
     Machine.AddCommand('run@double-to', _run_to_double);
     Machine.AddCommand('interpret@double-to', _interpret_to_double);
     Machine.AddCommand('double-value', _value_double);
     Machine.AddCommand('double-constant', _value_double);
     Machine.AddCommand('double-variable', _variable_double);
     Machine.AddCommand('double-literal', literal_double, True);
     Machine.AddCommand('double-(literal)', run_literal_double);
    
    
     Machine.AddCommand('extended-drop', drop_extended);
     Machine.AddCommand('extended-dup', dup_extended);
     Machine.AddCommand('extended-nip', nip_extended);
     Machine.AddCommand('extended-swap', swap_extended);
     Machine.AddCommand('extended-over', over_extended);
     Machine.AddCommand('extended-tuck', tuck_extended);
     Machine.AddCommand('extended-lrot', lrot_extended);
     Machine.AddCommand('extended-rrot', rrot_extended);
     Machine.AddCommand('extended-lrotn', lrotn_extended);
     Machine.AddCommand('extended-rrotn', rrotn_extended);
     Machine.AddCommand('extended-pick', pick_extended);
     Machine.AddCommand('extended,', _comma_extended);
     Machine.AddCommand('extended@', _dog_extended);
     Machine.AddCommand('extended!', _exclamation_extended);
     Machine.AddCommand('ptr+extended', ptr_plus_extended);
     Machine.AddCommand('extended-to', _to_extended, True);
     Machine.AddCommand('compile@extended-to', _compile_to_extended);
     Machine.AddCommand('run@extended-to', _run_to_extended);
     Machine.AddCommand('interpret@extended-to', _interpret_to_extended);
     Machine.AddCommand('extended-value', _value_extended);
     Machine.AddCommand('extended-constant', _value_extended);
     Machine.AddCommand('extended-variable', _variable_extended);
     Machine.AddCommand('extended-literal', literal_extended, True);
     Machine.AddCommand('extended-(literal)', run_literal_extended);
    ;
end;

end.
