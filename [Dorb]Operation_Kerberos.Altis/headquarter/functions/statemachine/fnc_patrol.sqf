/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sends a unit on a patrol around the Center
 *
 *  Parameter(s):
 *      0 : GROUP - the group on patrol
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _center = HASH_GET(GVAR(dangerzones),"centerpos");
private _distance = HASH_GET(GVAR(dangerzones),"distance");
TRACEV_3(_group,_center,_distance);
//[_group,_center,_distance, 5, "MOVE", "AWARE", "WHITE", "NORMAL", selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"], "", [5,10,15],50] call CBA_fnc_taskPatrol;
[_group, _center, _distance, "MOVE", "AWARE", "WHITE", "NORMAL", selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"], "", [5,10,15],50] call FUNC(statemachine_patrolTask);
