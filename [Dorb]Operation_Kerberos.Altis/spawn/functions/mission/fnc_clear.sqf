/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the cleaer task
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - hostages
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_distance",500,[0]]];

[_centerposition,4,_distance] call FUNC(spawnGroup_defence);

[]
