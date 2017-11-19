/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "prototype"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACEV_1(_this);
_this params ["_mission", "_targets"];

{
    _x addEventHandler["Killed", LINKFUNC(statemachine_decreaseCounter)];
    HASH_SET(_mission, "prototype", typeOf _x);
    _x lock 0;
} forEach _targets;

TRACEV_1(_targets);

[
    {
        _this params [["_mission",locationNull,[locationNull]],"_handle"];
        If !([_mission] call FUNC(statemachine_isActiveMission)) exitWith {
            TRACEV_3(_mission,_progress,_this);
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
        private _objects = _mission getVariable ["objects",[]];
        //TRACEV_1(_objects);
        {
            If ((!isNull _x)&&{alive _x}&&{crew _x isEqualTo []}&&{(_x distance2D (getMarkerPos GVARMAIN(rescuemarker)))<5}) then {
                [_x] call FUNC(statemachine_increaseCounter);
                deleteVehicle _x;
                [typeOf _object] spawn FUNC(spawn_createAtRescuePoint);
            };
        } forEach _objects;
    },
    15,
    _mission
] call CBA_fnc_addPerFrameHandler;
