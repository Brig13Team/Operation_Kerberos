/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onRespawn Event
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

_this params ["_unit","_corpse"];
CHECK(!(local _unit))

If ((GVAR(level)>0)&&{!isNil QGVAR(curList)}) then {
    [player] call FUNC(cleanPlayer);
};
