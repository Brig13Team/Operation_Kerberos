/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "hostage"
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
    [_x, true] call ace_captives_fnc_setHandcuffed;
    removeAllAssignedItems _x;
    removeAllWeapons _x;
    removeBackpack _x;

    _x addEventHandler ["Killed", LINKFUNC(statemachine_decreaseCounter)];
} forEach _targets;

[
    {
        _this params [["_mission",locationNull,[locationNull]],"_handle"];
        If !([_mission] call FUNC(statemachine_isActiveMission)) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
        private _objects = _mission getVariable ["objects",[]];
        {
            If ((!isNull _x)&&{alive _x}&&{vehicle _x == _x}&&{(_x distance2D (getMarkerPos GVARMAIN(rescuemarker)))<5}) then {
                [_x] call FUNC(statemachine_increaseCounter);
                deleteVehicle _x;
            };
        } forEach _objects;
    },
    15,
    _mission
] call CBA_fnc_addPerFrameHandler;
