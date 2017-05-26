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
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setVariable [QGVAR(rescueEvent), QFUNC(mainmission_prototype_rescued)];
    _x addEventHandler["Killed", LINKFUNC(obj__triggerFailed)];
    HASH_SET(_mission, "prototype", typeOf _x);
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
            If ((!isNull _x)&&{crew _x isEqualTo []}&&{(_x distance2D (getMarkerPos GVARMAIN(rescuemarker)))<5}) then {
                _mission setVariable["obj_counter",(_mission getVariable "obj_counter")+1];
                deleteVehicle _x;
                [typeOf _object] spawn FUNC(spawn_createAtRescuePoint);
            };
        } forEach _objects;
    },
    15,
    _mission
] call CBA_fnc_addPerFrameHandler;
