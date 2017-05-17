/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "Chopper" has failed
 *
 *  Parameter(s):
 *      0 : HASH      - mission hash
 *
 *  Returns:
 *      -
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _objects = _mission getVariable ["objects",[]];
_objects = _objects - [objNull];
TRACEV_2(_mission,_objects);
CHECK(_objects isEqualTo [])

private _group = group (_objects select 0);
(vehicle (leader _group)) setFuel 1;
TRACEV_2(_group,(vehicle (leader _group)));
[_group,"combat"] call EFUNC(headquarter,registerGroup);
