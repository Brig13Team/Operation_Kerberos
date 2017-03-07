/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a GROUP/OBJECT to the caching
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT/ARRAY - Thing to remove from cache
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[[],objNull,grpNull]]];

If !(IS_ARRAY(_target)) then {_target = [_target];};

{
    If (_x isEqualTypeAny [grpNull,objNull]) then {
        _x enableDynamicSimulation false;
    };
    nil
} count _target;
