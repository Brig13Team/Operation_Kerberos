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

_this params [["_hostage",objNull,[[],objNull]]];

CHECK(isNull)

If (IS_ARRAY(_hostage)) exitWith {
    {
        _this call FUNC(obj_init_hostage);
    } forEach _hostage;
};
_hostage setVariable [QGVAR(isActive),true];
_hostage setVariable [QGVAR(rescueEvent),QGVAR(hostage_captured)];

_hostage addEventHandler ["Killed", {
    [QGVAR(hostage_killed),_this] call CBA_fnc_serverEvent;}
];
