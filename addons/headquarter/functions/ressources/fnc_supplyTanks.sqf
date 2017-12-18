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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");

private _tanktype = ["tanks"] call EFUNC(spawn,getUnit);
If (_tanktype isEqualTo []) exitWith {0};
private _targetPos = [_centerpos,200,0] call EFUNC(common,pos_random);
private _spawnpos = [_targetPos] call FUNC(ressources_getSaveSpawnPos);
TRACEV_4(_centerpos,_tanktype,_targetPos,_spawnpos);
private _newGroup = ([_spawnpos,GVARMAIN(side),_tanktype] call EFUNC(spawn,vehicle)) select 0;

_newGroup setVariable [QGVAR(spawnpos),_spawnPos];
_newGroup setVariable [QGVAR(timeout),15*60];
_newGroup setVariable [QGVAR(state),"supply"];

(([_newGroup] call FUNC(getstrengthAIGroup)) param [0,0])
