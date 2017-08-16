/*
 *  Author: Dorbedo
 *
 *  Description:
 *      special spawnfunction for a supply transport
 *
 *  Parameter(s):
 *      0 : ARRAY - the centerpositions
 *
 *  Returns:
 *      ARRAY - Array with the supply wich have to be transported
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_centerpos","_mission"];

// spawn the TargetArea =
private _transportTargetPoint = [_centerpos, "supplys", 1, 500] call EFUNC(spawn,createMissionComposition);

TRACEV_2(_centerpos,_transportTargetPoint);

// spawn the container
private _Unittypes = ["supplys"] call FUNC(spawn_getObjects);
private _objects = [_Unittypes] call FUNC(spawn_createAtRescuepoint);

[
    {
        _this params ["_args","_handler"];
        _args params ["_mission","_objects","_targetPoint"];
        If ((isNull _mission)||{(_objects select {alive _x}) isEqualTo []}) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
        {
            if (((_x distance _targetpoint) < 5)&&{speed _x < 1}) then {
                deleteVehicle _x;
                HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
            };
        } forEach _objects;
    },
    15,
    [_mission,_objects,_transportTargetPoint]
] call CBA_fnc_addPerFrameHandler;

_objects;
//
