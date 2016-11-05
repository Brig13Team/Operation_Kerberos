/*
 *  Author: Dorbedo
 *
 *  Description:
 *      supplys with Tanks
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      SCALAR - costs
 *
 */
#include "script_component.hpp"

private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");

private _groupType = ["tanks"] call EFUNC(spawn,getUnit);
private _newGroup = [_spawnpos, _grouptype] call EFUNC(spawn,group);

private _targetPos = [_centerpos,200,0] call EFUNC(common,pos_random);

[_newGroup,"attack"] call FUNC(registerGroup);
[_newGroup,"retreat",_targetPos] call FUNC(state_set);

(([_newGroup] call FUNC(strenghtAi)) param [1,0]);
