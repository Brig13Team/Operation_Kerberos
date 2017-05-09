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

private _targetPos = HASH_GET(GVAR(dangerzones),"centerpos");

private _groupType = ["mechanized"] call EFUNC(spawn,getGroup);
if (isNull _groupType) exitWith {0};

private _spawnpos = [_targetPos] call FUNC(ressources_getSaveSpawnPos);
TRACEV_3(_grouptype,_spawnPos,_targetPos);
private _targetPos = [_targetPos,200,0] call EFUNC(common,pos_random);
private _newGroup = [_spawnpos, _grouptype] call EFUNC(spawn,group);

_newGroup setVariable [QGVAR(spawnpos),_spawnPos];
_newGroup setVariable [QGVAR(timeout),15*60];
_newGroup setVariable [QGVAR(state),"supply"];

(([_newGroup] call FUNC(getstrengthAIGroup)) param [0,0])
