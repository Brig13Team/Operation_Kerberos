/*
 *  Author: iJesuz
 *
 *  Description:
 *      call spawn function and call init-code
 *      (can be used for sidemission too)
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : CODE        - obj init code
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"
#define DEBUG_MODE_FULL

_this params ["_mission", "_init_code"];

// get settings
private _type     = HASH_GET(_mission, "type");
private _position = HASH_GET(_mission, "location") select 1;

// spawn target
private _parameter = [];
[_type] try { _parameter pushBack (_this call FUNC(mainmission___getAmount)); } catch {};
[_type] try { _parameter pushBack (_this call FUNC(mainmission___getRadius)); } catch {};
_objects = [_position, _type, _parameter] call EFUNC(spawn,createMissionTarget);
TRACEV_2(_parameter,_objects);

// initialize mission target(s)
{
    _x setVariable [QGVAR(mission), _mission];
    [_x] call _init_code;
} forEach _objects;

_objects
