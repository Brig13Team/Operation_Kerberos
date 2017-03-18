/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull,grpNull]]];

!(
    (isNull _target)
    ||{(IS_GROUP(_target))&&{!((leader _target) isEqualTo ace_player)}}
    ||{(IS_OBJECT(_target))&&{!local _target}}
)
