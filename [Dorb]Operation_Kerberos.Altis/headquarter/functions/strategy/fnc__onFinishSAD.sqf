/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called on finishing a attack
 *
 *  Parameter(s):
 *      0 : GROUP - The group who finished
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_groupleader"];

private _group = _groupleader call CBA_fnc_getGroup;
private _grouphash = _group getVariable QGVAR(grouphash);

private _target = HASH_GET(_grouphash,"target");

// move the group back to the center
private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
private _waitingPosition = [_centerpos,250] call EFUNC(common,pos_random);
[_group,"wait",_waitingPosition,""] call FUNC(state_set);

CHECK((isNil "_target")||{isNull _target})

private _strategy = HASH_GET_DEF(_grouphash,"strategy",locationNull);
CHECK(!(isNull _strategy))

HASH_DELETE(_strategy);
HASH_SET(_grouphash,"strategy",locationNull);
