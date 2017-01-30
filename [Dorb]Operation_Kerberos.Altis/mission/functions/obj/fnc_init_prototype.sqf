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

_this params [["_prototype",objNull,[[],objNull]]];

CHECK(isNull)

If (IS_ARRAY(_prototype)) exitWith {
    {
        _this call FUNC(obj_init_prototype);
    } forEach _prototype;
};
_prototype setVariable [QGVAR(isActive),true];
_prototype setVariable [QGVAR(rescueEvent),QGVAR(prototype_returned)];

_prototype addEventHandler ["Killed", {
    [QGVAR(prototype_destroyed),_this] call CBA_fnc_serverEvent;
}];
