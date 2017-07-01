/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if you are allowed to save the data
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - the save-target
 *
 *  Returns:
 *      BOOL - You are allowed to save the data
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
