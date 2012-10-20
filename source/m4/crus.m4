divert(`-1')
include(`../m4/cutils.m4')

define(`DECLARE',`divert(`0')
define(`_CUR_NAME_', `$1') divert(`-1')')

define(`NOTATION',`divert(`-1')')
define(`SUMMARY',`ifelse(_ENABLED_,`1', divert(`0')" _CUR_NAME_" " $1 define(`_ENABLED_',`'))')
define(`_SUMMARY',`" described divert(`-1')')
dnl define(`SUMMARY',`divert(`0')" _CUR_NAME_" " $1" described divert(`-1') define(`_ENABLED_',`')')
define(`DETAIL',`divert(`-1')')
define(`RUS',`define(`_ENABLED_',`1')')
