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

_this params [["_commander",objNull,[[],objNull]]];

If (IS_ARRAY(_commander)) exitWith {
    {
        _this call FUNC(obj_initcommander);
    } forEach _commander;
};
CHECK(isNull _commander)

_commander setVariable [QGVAR(isActive),true];
_commander setVariable [QGVAR(rescueEvent),QGVAR(commander_captured)];

_commander addEventHandler ["Killed", {
    [QGVAR(commander_killed),_this] call CBA_fnc_serverEvent;}
];
