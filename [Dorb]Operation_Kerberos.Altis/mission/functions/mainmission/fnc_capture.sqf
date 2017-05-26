/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      init mission "capture"
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
    _x allowFleeing 0;

    _x setVariable [QGVAR(rescueEvent), QFUNC(obj__increaseCounterOne)];
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounterTwo)];
} forEach _targets;

[
    {
        _this params [["_mission",locationNull,[locationNull]],"_handle"];
        private _progress = _mission getVariable ["progress","none"];
        If ((isNull _mission)||{_progress in ["cancel","succeeded","neutral","failed"]}) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
        private _objects = _mission getVariable ["objects",[]];
        {
            If ((!isNull _x)&&{vehicle _x == _x}&&{(_x distance2D (getMarkerPos GVARMAIN(rescuemarker)))<5}) then {
                _mission setVariable["obj_counter",(_mission getVariable "obj_counter")+1];
                deleteVehicle _x;
            };
        } forEach _objects;
    },
    15,
    _mission
] call CBA_fnc_addPerFrameHandler;
