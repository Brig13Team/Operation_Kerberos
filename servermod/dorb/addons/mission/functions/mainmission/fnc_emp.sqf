/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "emp"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["Killed", LINKFUNC(obj__decreaseCounter)];
} forEach _targets;

[
    {
        _this params [["_mission",locationNull,[locationNull]],"_handle"];
        If !([_mission] call FUNC(statemachine_isActiveMission)) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
        private _objects = _mission getVariable ["objects",[]];
        {
            If ((!isNull _x)&&{alive _x}&&{_x getVariable [QGVAR(isActive),true]}) then {
                [QGVAR(emp),[getPos _x]] call CBA_fnc_serverEvent;
            };
        } forEach _objects;
    },
    floor(800 + random 200),
    _mission
] call CBA_fnc_addPerFrameHandler;
