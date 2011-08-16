


















unit DCommandsArithmetic;

interface

uses
  {$I units.inc},

  DCommandsStrings,
  DForthMachine;



{$IFNDEF FLAG_FPC}{$REGION 'arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

  
  procedure _plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _minus (Machine: TForthMachine; Command: PForthCommand);
  procedure _star (Machine: TForthMachine; Command: PForthCommand);
  procedure _equel (Machine: TForthMachine; Command: PForthCommand);
  procedure _nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure _lt (Machine: TForthMachine; Command: PForthCommand);
  procedure _gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _lte (Machine: TForthMachine; Command: PForthCommand);
  procedure _gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure _0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure _ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure _if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure _max (Machine: TForthMachine; Command: PForthCommand);
  procedure _min (Machine: TForthMachine; Command: PForthCommand);
  procedure _minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure _dot (Machine: TForthMachine; Command: PForthCommand);
  procedure _dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int8_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int16_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int32_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int64_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint8_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint16_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint32_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint64_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure float_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure float_star (Machine: TForthMachine; Command: PForthCommand);
  procedure float_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure float_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure float_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure float_max (Machine: TForthMachine; Command: PForthCommand);
  procedure float_min (Machine: TForthMachine; Command: PForthCommand);
  procedure float_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure float_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure float_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure float_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure float_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure float_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure double_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure double_star (Machine: TForthMachine; Command: PForthCommand);
  procedure double_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure double_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure double_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure double_max (Machine: TForthMachine; Command: PForthCommand);
  procedure double_min (Machine: TForthMachine; Command: PForthCommand);
  procedure double_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure double_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure double_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure double_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure double_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure double_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_star (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure extended_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_max (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_min (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;

procedure LoadCommands(Machine: TForthMachine);

implementation

 
    
      procedure _plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end;  end; end;
      procedure _0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure _if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) <> 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure _max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure _min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure _minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
       end; end;
      procedure _dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' ');  end; end;
      procedure _dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt));  end; end;
      procedure _ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt));  end; end;
      procedure _conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)), B);
        Dec(WP, SizeOf(TInt));
        str_push(Machine, B);
       end; end;
      procedure _conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt(WP^));
        Inc(WP, SizeOf(TInt));
        DelRef(B);
       end; end;
    
   
    
      procedure int_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end;  end; end;
      procedure int_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure int_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) <> 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure int_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure int_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure int_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
       end; end;
      procedure int_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' ');  end; end;
      procedure int_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt));  end; end;
      procedure int_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt));  end; end;
      procedure int_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)), B);
        Dec(WP, SizeOf(TInt));
        str_push(Machine, B);
       end; end;
      procedure int_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt(WP^));
        Inc(WP, SizeOf(TInt));
        DelRef(B);
       end; end;
    
   
    
      procedure int8_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) + TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) - TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) * TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) = TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) <> TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) <= TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) >= TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) = 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <> 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) < 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) > 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) >= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <> 0 then begin TInt8(WP^) := TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)); Inc(WP, SizeOf(TInt8)); end;  end; end;
      procedure int8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) = 0 then begin Dec(WP, SizeOf(TInt8)); _exit(Machine, Command); end  end; end;
      procedure int8_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) <> 0 then begin Dec(WP, SizeOf(TInt8)); _exit(Machine, Command); end  end; end;
      procedure int8_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
       end; end;
      procedure int8_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
       end; end;
      procedure int8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), SizeOf(TInt8));
        end;
       end; end;
      procedure int8_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt8)); Write(TInt8(WP^), ' ');  end; end;
      procedure int8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt8; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt8)); Inc(WP, SizeOf(TInt8));  end; end;
      procedure int8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt8));  end; end;
      procedure int8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)), B);
        Dec(WP, SizeOf(TInt8));
        str_push(Machine, B);
       end; end;
      procedure int8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt8(WP^));
        Inc(WP, SizeOf(TInt8));
        DelRef(B);
       end; end;
    
   
    
      procedure int16_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) + TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) - TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) * TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) = TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) <> TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) <= TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) >= TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) = 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <> 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) < 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) > 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) >= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <> 0 then begin TInt16(WP^) := TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)); Inc(WP, SizeOf(TInt16)); end;  end; end;
      procedure int16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) = 0 then begin Dec(WP, SizeOf(TInt16)); _exit(Machine, Command); end  end; end;
      procedure int16_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) <> 0 then begin Dec(WP, SizeOf(TInt16)); _exit(Machine, Command); end  end; end;
      procedure int16_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
       end; end;
      procedure int16_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
       end; end;
      procedure int16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), SizeOf(TInt16));
        end;
       end; end;
      procedure int16_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt16)); Write(TInt16(WP^), ' ');  end; end;
      procedure int16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt16; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt16)); Inc(WP, SizeOf(TInt16));  end; end;
      procedure int16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt16));  end; end;
      procedure int16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)), B);
        Dec(WP, SizeOf(TInt16));
        str_push(Machine, B);
       end; end;
      procedure int16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt16(WP^));
        Inc(WP, SizeOf(TInt16));
        DelRef(B);
       end; end;
    
   
    
      procedure int32_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) + TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) - TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) * TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) = TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) <> TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) <= TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) >= TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) = 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <> 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) < 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) > 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) >= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <> 0 then begin TInt32(WP^) := TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)); Inc(WP, SizeOf(TInt32)); end;  end; end;
      procedure int32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) = 0 then begin Dec(WP, SizeOf(TInt32)); _exit(Machine, Command); end  end; end;
      procedure int32_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) <> 0 then begin Dec(WP, SizeOf(TInt32)); _exit(Machine, Command); end  end; end;
      procedure int32_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
       end; end;
      procedure int32_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
       end; end;
      procedure int32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), SizeOf(TInt32));
        end;
       end; end;
      procedure int32_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt32)); Write(TInt32(WP^), ' ');  end; end;
      procedure int32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt32; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt32)); Inc(WP, SizeOf(TInt32));  end; end;
      procedure int32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt32));  end; end;
      procedure int32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)), B);
        Dec(WP, SizeOf(TInt32));
        str_push(Machine, B);
       end; end;
      procedure int32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt32(WP^));
        Inc(WP, SizeOf(TInt32));
        DelRef(B);
       end; end;
    
   
    
      procedure int64_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) + TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) - TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) * TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) = TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) <> TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) <= TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) >= TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) = 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <> 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) < 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) > 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) >= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <> 0 then begin TInt64(WP^) := TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)); Inc(WP, SizeOf(TInt64)); end;  end; end;
      procedure int64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) = 0 then begin Dec(WP, SizeOf(TInt64)); _exit(Machine, Command); end  end; end;
      procedure int64_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) <> 0 then begin Dec(WP, SizeOf(TInt64)); _exit(Machine, Command); end  end; end;
      procedure int64_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
       end; end;
      procedure int64_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
       end; end;
      procedure int64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), SizeOf(TInt64));
        end;
       end; end;
      procedure int64_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt64)); Write(TInt64(WP^), ' ');  end; end;
      procedure int64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt64; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt64)); Inc(WP, SizeOf(TInt64));  end; end;
      procedure int64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt64));  end; end;
      procedure int64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)), B);
        Dec(WP, SizeOf(TInt64));
        str_push(Machine, B);
       end; end;
      procedure int64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt64(WP^));
        Inc(WP, SizeOf(TInt64));
        DelRef(B);
       end; end;
    
   
    
      procedure uint_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) + TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) - TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) * TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) = TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) <> TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) <= TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) >= TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) = 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <> 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) < 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) > 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) >= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <> 0 then begin TUInt(WP^) := TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)); Inc(WP, SizeOf(TUInt)); end;  end; end;
      procedure uint_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) = 0 then begin Dec(WP, SizeOf(TUInt)); _exit(Machine, Command); end  end; end;
      procedure uint_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt)); _exit(Machine, Command); end  end; end;
      procedure uint_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
       end; end;
      procedure uint_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
       end; end;
      procedure uint_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), SizeOf(TUInt));
        end;
       end; end;
      procedure uint_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt)); Write(TUInt(WP^), ' ');  end; end;
      procedure uint_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt)); Inc(WP, SizeOf(TUInt));  end; end;
      procedure uint_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt));  end; end;
      procedure uint_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)), B);
        Dec(WP, SizeOf(TUInt));
        str_push(Machine, B);
       end; end;
      procedure uint_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt(WP^));
        Inc(WP, SizeOf(TUInt));
        DelRef(B);
       end; end;
    
   
    
      procedure uint8_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) + TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) - TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) * TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) = TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) <> TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) <= TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) >= TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) = 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <> 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) < 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) > 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) >= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <> 0 then begin TUInt8(WP^) := TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)); Inc(WP, SizeOf(TUInt8)); end;  end; end;
      procedure uint8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) = 0 then begin Dec(WP, SizeOf(TUInt8)); _exit(Machine, Command); end  end; end;
      procedure uint8_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt8)); _exit(Machine, Command); end  end; end;
      procedure uint8_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
       end; end;
      procedure uint8_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
       end; end;
      procedure uint8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        end;
       end; end;
      procedure uint8_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt8)); Write(TUInt8(WP^), ' ');  end; end;
      procedure uint8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt8; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt8)); Inc(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt8));  end; end;
      procedure uint8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)), B);
        Dec(WP, SizeOf(TUInt8));
        str_push(Machine, B);
       end; end;
      procedure uint8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt8(WP^));
        Inc(WP, SizeOf(TUInt8));
        DelRef(B);
       end; end;
    
   
    
      procedure uint16_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) + TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) - TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) * TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) = TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) <> TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) <= TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) >= TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) = 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <> 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) < 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) > 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) >= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <> 0 then begin TUInt16(WP^) := TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)); Inc(WP, SizeOf(TUInt16)); end;  end; end;
      procedure uint16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) = 0 then begin Dec(WP, SizeOf(TUInt16)); _exit(Machine, Command); end  end; end;
      procedure uint16_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt16)); _exit(Machine, Command); end  end; end;
      procedure uint16_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
       end; end;
      procedure uint16_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
       end; end;
      procedure uint16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        end;
       end; end;
      procedure uint16_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt16)); Write(TUInt16(WP^), ' ');  end; end;
      procedure uint16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt16; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt16)); Inc(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt16));  end; end;
      procedure uint16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)), B);
        Dec(WP, SizeOf(TUInt16));
        str_push(Machine, B);
       end; end;
      procedure uint16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt16(WP^));
        Inc(WP, SizeOf(TUInt16));
        DelRef(B);
       end; end;
    
   
    
      procedure uint32_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) + TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) - TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) * TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) = TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) <> TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) <= TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) >= TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) = 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <> 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) < 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) > 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) >= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <> 0 then begin TUInt32(WP^) := TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)); Inc(WP, SizeOf(TUInt32)); end;  end; end;
      procedure uint32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) = 0 then begin Dec(WP, SizeOf(TUInt32)); _exit(Machine, Command); end  end; end;
      procedure uint32_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt32)); _exit(Machine, Command); end  end; end;
      procedure uint32_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
       end; end;
      procedure uint32_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
       end; end;
      procedure uint32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        end;
       end; end;
      procedure uint32_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt32)); Write(TUInt32(WP^), ' ');  end; end;
      procedure uint32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt32; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt32)); Inc(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt32));  end; end;
      procedure uint32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)), B);
        Dec(WP, SizeOf(TUInt32));
        str_push(Machine, B);
       end; end;
      procedure uint32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt32(WP^));
        Inc(WP, SizeOf(TUInt32));
        DelRef(B);
       end; end;
    
   
    
      procedure uint64_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) + TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) - TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) * TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) = TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) <> TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) <= TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) >= TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) = 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <> 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) < 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) > 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) >= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <> 0 then begin TUInt64(WP^) := TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)); Inc(WP, SizeOf(TUInt64)); end;  end; end;
      procedure uint64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) = 0 then begin Dec(WP, SizeOf(TUInt64)); _exit(Machine, Command); end  end; end;
      procedure uint64_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt64)); _exit(Machine, Command); end  end; end;
      procedure uint64_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
       end; end;
      procedure uint64_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
       end; end;
      procedure uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        end;
       end; end;
      procedure uint64_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt64)); Write(TUInt64(WP^), ' ');  end; end;
      procedure uint64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt64; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt64)); Inc(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt64));  end; end;
      procedure uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)), B);
        Dec(WP, SizeOf(TUInt64));
        str_push(Machine, B);
       end; end;
      procedure uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt64(WP^));
        Inc(WP, SizeOf(TUInt64));
        DelRef(B);
       end; end;
    
   
    
      procedure float_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) + Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) - Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) * Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) = Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) <> Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) <= Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) >= Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) = 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <> 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) < 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) > 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) >= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <> 0 then begin Single(WP^) := Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)); Inc(WP, SizeOf(Single)); end;  end; end;
      procedure float_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) = 0 then begin Dec(WP, SizeOf(Single)); _exit(Machine, Command); end  end; end;
      procedure float_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) <> 0 then begin Dec(WP, SizeOf(Single)); _exit(Machine, Command); end  end; end;
      procedure float_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
       end; end;
      procedure float_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
       end; end;
      procedure float_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), SizeOf(Single));
        end;
       end; end;
      procedure float_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Single)); Write(Single(WP^), ' ');  end; end;
      procedure float_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Single; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Single)); Inc(WP, SizeOf(Single));  end; end;
      procedure float_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Single(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Single)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Single));  end; end;
      procedure float_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)), B);
        Dec(WP, SizeOf(Single));
        str_push(Machine, B);
       end; end;
      procedure float_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Single(WP^));
        Inc(WP, SizeOf(Single));
        DelRef(B);
       end; end;
    
   
    
      procedure double_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) + Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) - Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) * Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) = Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) <> Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) <= Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) >= Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) = 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <> 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) < 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) > 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) >= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <> 0 then begin Double(WP^) := Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)); Inc(WP, SizeOf(Double)); end;  end; end;
      procedure double_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) = 0 then begin Dec(WP, SizeOf(Double)); _exit(Machine, Command); end  end; end;
      procedure double_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) <> 0 then begin Dec(WP, SizeOf(Double)); _exit(Machine, Command); end  end; end;
      procedure double_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
       end; end;
      procedure double_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
       end; end;
      procedure double_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), SizeOf(Double));
        end;
       end; end;
      procedure double_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Double)); Write(Double(WP^), ' ');  end; end;
      procedure double_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Double; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Double)); Inc(WP, SizeOf(Double));  end; end;
      procedure double_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Double(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Double)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Double));  end; end;
      procedure double_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)), B);
        Dec(WP, SizeOf(Double));
        str_push(Machine, B);
       end; end;
      procedure double_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Double(WP^));
        Inc(WP, SizeOf(Double));
        DelRef(B);
       end; end;
    
   
    
      procedure extended_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) + Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) - Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) * Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) = Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) <> Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) <= Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) >= Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) = 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <> 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) < 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) > 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) >= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <> 0 then begin Extended(WP^) := Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)); Inc(WP, SizeOf(Extended)); end;  end; end;
      procedure extended_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) = 0 then begin Dec(WP, SizeOf(Extended)); _exit(Machine, Command); end  end; end;
      procedure extended_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) <> 0 then begin Dec(WP, SizeOf(Extended)); _exit(Machine, Command); end  end; end;
      procedure extended_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
       end; end;
      procedure extended_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
       end; end;
      procedure extended_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), SizeOf(Extended));
        end;
       end; end;
      procedure extended_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Extended)); Write(Extended(WP^), ' ');  end; end;
      procedure extended_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Extended; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Extended)); Inc(WP, SizeOf(Extended));  end; end;
      procedure extended_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Extended(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Extended)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Extended));  end; end;
      procedure extended_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)), B);
        Dec(WP, SizeOf(Extended));
        str_push(Machine, B);
       end; end;
      procedure extended_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Extended(WP^));
        Inc(WP, SizeOf(Extended));
        DelRef(B);
       end; end;
    
  

procedure LoadCommands(Machine: TForthMachine);
begin
  
    
     Machine.AddCommand('+', _plus);
     Machine.AddCommand('-', _minus);
     Machine.AddCommand('*', _star);
     Machine.AddCommand('=', _equel);
     Machine.AddCommand('<>', _nequel);
     Machine.AddCommand('<', _lt);
     Machine.AddCommand('>', _gt);
     Machine.AddCommand('<=', _lte);
     Machine.AddCommand('>=', _gte);
     Machine.AddCommand('0=', _0_equel);
     Machine.AddCommand('0<>', _0_nequel);
     Machine.AddCommand('0<', _0_lt);
     Machine.AddCommand('0>', _0_gt);
     Machine.AddCommand('0<=', _0_lte);
     Machine.AddCommand('0>=', _0_gte);
     Machine.AddCommand('?dup', _ask_dup);
     Machine.Addcommand('0;', _0_exit);
     Machine.Addcommand('if;', _if_exit);
     Machine.AddCommand('min', _min);
     Machine.AddCommand('max', _max);
     Machine.AddCommand('minmax', _minmax);
     Machine.AddCommand('.', _dot);
     Machine.AddCommand('$', _dollar);
     Machine.AddCommand('+!', _ptr_plus_exclamation);
     Machine.AddCommand('->str', _conv_to_str);
     Machine.AddCommand('str->', _conv_from_str);
    
    
     Machine.AddCommand('int+', int_plus);
     Machine.AddCommand('int-', int_minus);
     Machine.AddCommand('int*', int_star);
     Machine.AddCommand('int=', int_equel);
     Machine.AddCommand('int<>', int_nequel);
     Machine.AddCommand('int<', int_lt);
     Machine.AddCommand('int>', int_gt);
     Machine.AddCommand('int<=', int_lte);
     Machine.AddCommand('int>=', int_gte);
     Machine.AddCommand('int-0=', int_0_equel);
     Machine.AddCommand('int-0<>', int_0_nequel);
     Machine.AddCommand('int-0<', int_0_lt);
     Machine.AddCommand('int-0>', int_0_gt);
     Machine.AddCommand('int-0<=', int_0_lte);
     Machine.AddCommand('int-0>=', int_0_gte);
     Machine.AddCommand('int-?dup', int_ask_dup);
     Machine.Addcommand('int-0;', int_0_exit);
     Machine.Addcommand('int-if;', int_if_exit);
     Machine.AddCommand('int-min', int_min);
     Machine.AddCommand('int-max', int_max);
     Machine.AddCommand('int-minmax', int_minmax);
     Machine.AddCommand('int.', int_dot);
     Machine.AddCommand('int$', int_dollar);
     Machine.AddCommand('int+!', int_ptr_plus_exclamation);
     Machine.AddCommand('int->str', int_conv_to_str);
     Machine.AddCommand('str->int', int_conv_from_str);
    
    
     Machine.AddCommand('int8+', int8_plus);
     Machine.AddCommand('int8-', int8_minus);
     Machine.AddCommand('int8*', int8_star);
     Machine.AddCommand('int8=', int8_equel);
     Machine.AddCommand('int8<>', int8_nequel);
     Machine.AddCommand('int8<', int8_lt);
     Machine.AddCommand('int8>', int8_gt);
     Machine.AddCommand('int8<=', int8_lte);
     Machine.AddCommand('int8>=', int8_gte);
     Machine.AddCommand('int8-0=', int8_0_equel);
     Machine.AddCommand('int8-0<>', int8_0_nequel);
     Machine.AddCommand('int8-0<', int8_0_lt);
     Machine.AddCommand('int8-0>', int8_0_gt);
     Machine.AddCommand('int8-0<=', int8_0_lte);
     Machine.AddCommand('int8-0>=', int8_0_gte);
     Machine.AddCommand('int8-?dup', int8_ask_dup);
     Machine.Addcommand('int8-0;', int8_0_exit);
     Machine.Addcommand('int8-if;', int8_if_exit);
     Machine.AddCommand('int8-min', int8_min);
     Machine.AddCommand('int8-max', int8_max);
     Machine.AddCommand('int8-minmax', int8_minmax);
     Machine.AddCommand('int8.', int8_dot);
     Machine.AddCommand('int8$', int8_dollar);
     Machine.AddCommand('int8+!', int8_ptr_plus_exclamation);
     Machine.AddCommand('int8->str', int8_conv_to_str);
     Machine.AddCommand('str->int8', int8_conv_from_str);
    
    
     Machine.AddCommand('int16+', int16_plus);
     Machine.AddCommand('int16-', int16_minus);
     Machine.AddCommand('int16*', int16_star);
     Machine.AddCommand('int16=', int16_equel);
     Machine.AddCommand('int16<>', int16_nequel);
     Machine.AddCommand('int16<', int16_lt);
     Machine.AddCommand('int16>', int16_gt);
     Machine.AddCommand('int16<=', int16_lte);
     Machine.AddCommand('int16>=', int16_gte);
     Machine.AddCommand('int16-0=', int16_0_equel);
     Machine.AddCommand('int16-0<>', int16_0_nequel);
     Machine.AddCommand('int16-0<', int16_0_lt);
     Machine.AddCommand('int16-0>', int16_0_gt);
     Machine.AddCommand('int16-0<=', int16_0_lte);
     Machine.AddCommand('int16-0>=', int16_0_gte);
     Machine.AddCommand('int16-?dup', int16_ask_dup);
     Machine.Addcommand('int16-0;', int16_0_exit);
     Machine.Addcommand('int16-if;', int16_if_exit);
     Machine.AddCommand('int16-min', int16_min);
     Machine.AddCommand('int16-max', int16_max);
     Machine.AddCommand('int16-minmax', int16_minmax);
     Machine.AddCommand('int16.', int16_dot);
     Machine.AddCommand('int16$', int16_dollar);
     Machine.AddCommand('int16+!', int16_ptr_plus_exclamation);
     Machine.AddCommand('int16->str', int16_conv_to_str);
     Machine.AddCommand('str->int16', int16_conv_from_str);
    
    
     Machine.AddCommand('int32+', int32_plus);
     Machine.AddCommand('int32-', int32_minus);
     Machine.AddCommand('int32*', int32_star);
     Machine.AddCommand('int32=', int32_equel);
     Machine.AddCommand('int32<>', int32_nequel);
     Machine.AddCommand('int32<', int32_lt);
     Machine.AddCommand('int32>', int32_gt);
     Machine.AddCommand('int32<=', int32_lte);
     Machine.AddCommand('int32>=', int32_gte);
     Machine.AddCommand('int32-0=', int32_0_equel);
     Machine.AddCommand('int32-0<>', int32_0_nequel);
     Machine.AddCommand('int32-0<', int32_0_lt);
     Machine.AddCommand('int32-0>', int32_0_gt);
     Machine.AddCommand('int32-0<=', int32_0_lte);
     Machine.AddCommand('int32-0>=', int32_0_gte);
     Machine.AddCommand('int32-?dup', int32_ask_dup);
     Machine.Addcommand('int32-0;', int32_0_exit);
     Machine.Addcommand('int32-if;', int32_if_exit);
     Machine.AddCommand('int32-min', int32_min);
     Machine.AddCommand('int32-max', int32_max);
     Machine.AddCommand('int32-minmax', int32_minmax);
     Machine.AddCommand('int32.', int32_dot);
     Machine.AddCommand('int32$', int32_dollar);
     Machine.AddCommand('int32+!', int32_ptr_plus_exclamation);
     Machine.AddCommand('int32->str', int32_conv_to_str);
     Machine.AddCommand('str->int32', int32_conv_from_str);
    
    
     Machine.AddCommand('int64+', int64_plus);
     Machine.AddCommand('int64-', int64_minus);
     Machine.AddCommand('int64*', int64_star);
     Machine.AddCommand('int64=', int64_equel);
     Machine.AddCommand('int64<>', int64_nequel);
     Machine.AddCommand('int64<', int64_lt);
     Machine.AddCommand('int64>', int64_gt);
     Machine.AddCommand('int64<=', int64_lte);
     Machine.AddCommand('int64>=', int64_gte);
     Machine.AddCommand('int64-0=', int64_0_equel);
     Machine.AddCommand('int64-0<>', int64_0_nequel);
     Machine.AddCommand('int64-0<', int64_0_lt);
     Machine.AddCommand('int64-0>', int64_0_gt);
     Machine.AddCommand('int64-0<=', int64_0_lte);
     Machine.AddCommand('int64-0>=', int64_0_gte);
     Machine.AddCommand('int64-?dup', int64_ask_dup);
     Machine.Addcommand('int64-0;', int64_0_exit);
     Machine.Addcommand('int64-if;', int64_if_exit);
     Machine.AddCommand('int64-min', int64_min);
     Machine.AddCommand('int64-max', int64_max);
     Machine.AddCommand('int64-minmax', int64_minmax);
     Machine.AddCommand('int64.', int64_dot);
     Machine.AddCommand('int64$', int64_dollar);
     Machine.AddCommand('int64+!', int64_ptr_plus_exclamation);
     Machine.AddCommand('int64->str', int64_conv_to_str);
     Machine.AddCommand('str->int64', int64_conv_from_str);
    
    
     Machine.AddCommand('uint+', uint_plus);
     Machine.AddCommand('uint-', uint_minus);
     Machine.AddCommand('uint*', uint_star);
     Machine.AddCommand('uint=', uint_equel);
     Machine.AddCommand('uint<>', uint_nequel);
     Machine.AddCommand('uint<', uint_lt);
     Machine.AddCommand('uint>', uint_gt);
     Machine.AddCommand('uint<=', uint_lte);
     Machine.AddCommand('uint>=', uint_gte);
     Machine.AddCommand('uint-0=', uint_0_equel);
     Machine.AddCommand('uint-0<>', uint_0_nequel);
     Machine.AddCommand('uint-0<', uint_0_lt);
     Machine.AddCommand('uint-0>', uint_0_gt);
     Machine.AddCommand('uint-0<=', uint_0_lte);
     Machine.AddCommand('uint-0>=', uint_0_gte);
     Machine.AddCommand('uint-?dup', uint_ask_dup);
     Machine.Addcommand('uint-0;', uint_0_exit);
     Machine.Addcommand('uint-if;', uint_if_exit);
     Machine.AddCommand('uint-min', uint_min);
     Machine.AddCommand('uint-max', uint_max);
     Machine.AddCommand('uint-minmax', uint_minmax);
     Machine.AddCommand('uint.', uint_dot);
     Machine.AddCommand('uint$', uint_dollar);
     Machine.AddCommand('uint+!', uint_ptr_plus_exclamation);
     Machine.AddCommand('uint->str', uint_conv_to_str);
     Machine.AddCommand('str->uint', uint_conv_from_str);
    
    
     Machine.AddCommand('uint8+', uint8_plus);
     Machine.AddCommand('uint8-', uint8_minus);
     Machine.AddCommand('uint8*', uint8_star);
     Machine.AddCommand('uint8=', uint8_equel);
     Machine.AddCommand('uint8<>', uint8_nequel);
     Machine.AddCommand('uint8<', uint8_lt);
     Machine.AddCommand('uint8>', uint8_gt);
     Machine.AddCommand('uint8<=', uint8_lte);
     Machine.AddCommand('uint8>=', uint8_gte);
     Machine.AddCommand('uint8-0=', uint8_0_equel);
     Machine.AddCommand('uint8-0<>', uint8_0_nequel);
     Machine.AddCommand('uint8-0<', uint8_0_lt);
     Machine.AddCommand('uint8-0>', uint8_0_gt);
     Machine.AddCommand('uint8-0<=', uint8_0_lte);
     Machine.AddCommand('uint8-0>=', uint8_0_gte);
     Machine.AddCommand('uint8-?dup', uint8_ask_dup);
     Machine.Addcommand('uint8-0;', uint8_0_exit);
     Machine.Addcommand('uint8-if;', uint8_if_exit);
     Machine.AddCommand('uint8-min', uint8_min);
     Machine.AddCommand('uint8-max', uint8_max);
     Machine.AddCommand('uint8-minmax', uint8_minmax);
     Machine.AddCommand('uint8.', uint8_dot);
     Machine.AddCommand('uint8$', uint8_dollar);
     Machine.AddCommand('uint8+!', uint8_ptr_plus_exclamation);
     Machine.AddCommand('uint8->str', uint8_conv_to_str);
     Machine.AddCommand('str->uint8', uint8_conv_from_str);
    
    
     Machine.AddCommand('uint16+', uint16_plus);
     Machine.AddCommand('uint16-', uint16_minus);
     Machine.AddCommand('uint16*', uint16_star);
     Machine.AddCommand('uint16=', uint16_equel);
     Machine.AddCommand('uint16<>', uint16_nequel);
     Machine.AddCommand('uint16<', uint16_lt);
     Machine.AddCommand('uint16>', uint16_gt);
     Machine.AddCommand('uint16<=', uint16_lte);
     Machine.AddCommand('uint16>=', uint16_gte);
     Machine.AddCommand('uint16-0=', uint16_0_equel);
     Machine.AddCommand('uint16-0<>', uint16_0_nequel);
     Machine.AddCommand('uint16-0<', uint16_0_lt);
     Machine.AddCommand('uint16-0>', uint16_0_gt);
     Machine.AddCommand('uint16-0<=', uint16_0_lte);
     Machine.AddCommand('uint16-0>=', uint16_0_gte);
     Machine.AddCommand('uint16-?dup', uint16_ask_dup);
     Machine.Addcommand('uint16-0;', uint16_0_exit);
     Machine.Addcommand('uint16-if;', uint16_if_exit);
     Machine.AddCommand('uint16-min', uint16_min);
     Machine.AddCommand('uint16-max', uint16_max);
     Machine.AddCommand('uint16-minmax', uint16_minmax);
     Machine.AddCommand('uint16.', uint16_dot);
     Machine.AddCommand('uint16$', uint16_dollar);
     Machine.AddCommand('uint16+!', uint16_ptr_plus_exclamation);
     Machine.AddCommand('uint16->str', uint16_conv_to_str);
     Machine.AddCommand('str->uint16', uint16_conv_from_str);
    
    
     Machine.AddCommand('uint32+', uint32_plus);
     Machine.AddCommand('uint32-', uint32_minus);
     Machine.AddCommand('uint32*', uint32_star);
     Machine.AddCommand('uint32=', uint32_equel);
     Machine.AddCommand('uint32<>', uint32_nequel);
     Machine.AddCommand('uint32<', uint32_lt);
     Machine.AddCommand('uint32>', uint32_gt);
     Machine.AddCommand('uint32<=', uint32_lte);
     Machine.AddCommand('uint32>=', uint32_gte);
     Machine.AddCommand('uint32-0=', uint32_0_equel);
     Machine.AddCommand('uint32-0<>', uint32_0_nequel);
     Machine.AddCommand('uint32-0<', uint32_0_lt);
     Machine.AddCommand('uint32-0>', uint32_0_gt);
     Machine.AddCommand('uint32-0<=', uint32_0_lte);
     Machine.AddCommand('uint32-0>=', uint32_0_gte);
     Machine.AddCommand('uint32-?dup', uint32_ask_dup);
     Machine.Addcommand('uint32-0;', uint32_0_exit);
     Machine.Addcommand('uint32-if;', uint32_if_exit);
     Machine.AddCommand('uint32-min', uint32_min);
     Machine.AddCommand('uint32-max', uint32_max);
     Machine.AddCommand('uint32-minmax', uint32_minmax);
     Machine.AddCommand('uint32.', uint32_dot);
     Machine.AddCommand('uint32$', uint32_dollar);
     Machine.AddCommand('uint32+!', uint32_ptr_plus_exclamation);
     Machine.AddCommand('uint32->str', uint32_conv_to_str);
     Machine.AddCommand('str->uint32', uint32_conv_from_str);
    
    
     Machine.AddCommand('uint64+', uint64_plus);
     Machine.AddCommand('uint64-', uint64_minus);
     Machine.AddCommand('uint64*', uint64_star);
     Machine.AddCommand('uint64=', uint64_equel);
     Machine.AddCommand('uint64<>', uint64_nequel);
     Machine.AddCommand('uint64<', uint64_lt);
     Machine.AddCommand('uint64>', uint64_gt);
     Machine.AddCommand('uint64<=', uint64_lte);
     Machine.AddCommand('uint64>=', uint64_gte);
     Machine.AddCommand('uint64-0=', uint64_0_equel);
     Machine.AddCommand('uint64-0<>', uint64_0_nequel);
     Machine.AddCommand('uint64-0<', uint64_0_lt);
     Machine.AddCommand('uint64-0>', uint64_0_gt);
     Machine.AddCommand('uint64-0<=', uint64_0_lte);
     Machine.AddCommand('uint64-0>=', uint64_0_gte);
     Machine.AddCommand('uint64-?dup', uint64_ask_dup);
     Machine.Addcommand('uint64-0;', uint64_0_exit);
     Machine.Addcommand('uint64-if;', uint64_if_exit);
     Machine.AddCommand('uint64-min', uint64_min);
     Machine.AddCommand('uint64-max', uint64_max);
     Machine.AddCommand('uint64-minmax', uint64_minmax);
     Machine.AddCommand('uint64.', uint64_dot);
     Machine.AddCommand('uint64$', uint64_dollar);
     Machine.AddCommand('uint64+!', uint64_ptr_plus_exclamation);
     Machine.AddCommand('uint64->str', uint64_conv_to_str);
     Machine.AddCommand('str->uint64', uint64_conv_from_str);
    
    
     Machine.AddCommand('float+', float_plus);
     Machine.AddCommand('float-', float_minus);
     Machine.AddCommand('float*', float_star);
     Machine.AddCommand('float=', float_equel);
     Machine.AddCommand('float<>', float_nequel);
     Machine.AddCommand('float<', float_lt);
     Machine.AddCommand('float>', float_gt);
     Machine.AddCommand('float<=', float_lte);
     Machine.AddCommand('float>=', float_gte);
     Machine.AddCommand('float-0=', float_0_equel);
     Machine.AddCommand('float-0<>', float_0_nequel);
     Machine.AddCommand('float-0<', float_0_lt);
     Machine.AddCommand('float-0>', float_0_gt);
     Machine.AddCommand('float-0<=', float_0_lte);
     Machine.AddCommand('float-0>=', float_0_gte);
     Machine.AddCommand('float-?dup', float_ask_dup);
     Machine.Addcommand('float-0;', float_0_exit);
     Machine.Addcommand('float-if;', float_if_exit);
     Machine.AddCommand('float-min', float_min);
     Machine.AddCommand('float-max', float_max);
     Machine.AddCommand('float-minmax', float_minmax);
     Machine.AddCommand('float.', float_dot);
     Machine.AddCommand('float$', float_dollar);
     Machine.AddCommand('float+!', float_ptr_plus_exclamation);
     Machine.AddCommand('float->str', float_conv_to_str);
     Machine.AddCommand('str->float', float_conv_from_str);
    
    
     Machine.AddCommand('double+', double_plus);
     Machine.AddCommand('double-', double_minus);
     Machine.AddCommand('double*', double_star);
     Machine.AddCommand('double=', double_equel);
     Machine.AddCommand('double<>', double_nequel);
     Machine.AddCommand('double<', double_lt);
     Machine.AddCommand('double>', double_gt);
     Machine.AddCommand('double<=', double_lte);
     Machine.AddCommand('double>=', double_gte);
     Machine.AddCommand('double-0=', double_0_equel);
     Machine.AddCommand('double-0<>', double_0_nequel);
     Machine.AddCommand('double-0<', double_0_lt);
     Machine.AddCommand('double-0>', double_0_gt);
     Machine.AddCommand('double-0<=', double_0_lte);
     Machine.AddCommand('double-0>=', double_0_gte);
     Machine.AddCommand('double-?dup', double_ask_dup);
     Machine.Addcommand('double-0;', double_0_exit);
     Machine.Addcommand('double-if;', double_if_exit);
     Machine.AddCommand('double-min', double_min);
     Machine.AddCommand('double-max', double_max);
     Machine.AddCommand('double-minmax', double_minmax);
     Machine.AddCommand('double.', double_dot);
     Machine.AddCommand('double$', double_dollar);
     Machine.AddCommand('double+!', double_ptr_plus_exclamation);
     Machine.AddCommand('double->str', double_conv_to_str);
     Machine.AddCommand('str->double', double_conv_from_str);
    
    
     Machine.AddCommand('extended+', extended_plus);
     Machine.AddCommand('extended-', extended_minus);
     Machine.AddCommand('extended*', extended_star);
     Machine.AddCommand('extended=', extended_equel);
     Machine.AddCommand('extended<>', extended_nequel);
     Machine.AddCommand('extended<', extended_lt);
     Machine.AddCommand('extended>', extended_gt);
     Machine.AddCommand('extended<=', extended_lte);
     Machine.AddCommand('extended>=', extended_gte);
     Machine.AddCommand('extended-0=', extended_0_equel);
     Machine.AddCommand('extended-0<>', extended_0_nequel);
     Machine.AddCommand('extended-0<', extended_0_lt);
     Machine.AddCommand('extended-0>', extended_0_gt);
     Machine.AddCommand('extended-0<=', extended_0_lte);
     Machine.AddCommand('extended-0>=', extended_0_gte);
     Machine.AddCommand('extended-?dup', extended_ask_dup);
     Machine.Addcommand('extended-0;', extended_0_exit);
     Machine.Addcommand('extended-if;', extended_if_exit);
     Machine.AddCommand('extended-min', extended_min);
     Machine.AddCommand('extended-max', extended_max);
     Machine.AddCommand('extended-minmax', extended_minmax);
     Machine.AddCommand('extended.', extended_dot);
     Machine.AddCommand('extended$', extended_dollar);
     Machine.AddCommand('extended+!', extended_ptr_plus_exclamation);
     Machine.AddCommand('extended->str', extended_conv_to_str);
     Machine.AddCommand('str->extended', extended_conv_from_str);
    ;
end;

end.
