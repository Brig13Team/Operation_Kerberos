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

private _tanktype = ["tanks"] call EFUNC(spawn,getUnit);
If (_tanktype isEqualTo []) exitWith {0};
private _targetPos = [_centerpos,200,0] call EFUNC(common,pos_random);
private _spawnpos = [_targetPos,_tanktype] call FUNC(ressources_getSaveSpawnPos);
private _newGroup = ([_spawnpos,GVARMAIN(side),_tanktype] call EFUNC(spawn,vehicle)) select 0;

[_newGroup,"attack"] call FUNC(registerGroup);
[_newGroup,"retreat",_targetPos] call FUNC(state_set);

(([_newGroup] call FUNC(strenghtAi)) param [1,0]);
