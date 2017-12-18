/**
 * Author: Dorbedo
 * mission airsuperiority
 *
 * Arguments:
 * 0: <LOCATION> mission
 * 1: <ARRAY> the mission objects
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_mission", "_targets"];

{
    _x addEventHandler ["Killed", LINKFUNC(statemachine_increaseCounter)];
} forEach _targets;

[
    {
        params ["_planes","_handler"];
        if (({
            _x params [["_unit",objNull]];
            If (isNull _unit) then {
                false
            } else {
                _unit setVehicleAmmo 1;
                _unit setFuel 1;
                true
            };
        } count _planes)==0) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
    },
    60,
    [_targets]
] call CBA_fnc_addPerFrameHandler;
