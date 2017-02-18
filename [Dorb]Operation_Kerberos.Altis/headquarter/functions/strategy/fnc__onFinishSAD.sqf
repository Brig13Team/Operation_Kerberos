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

CHECK((isNil "_target")||{isNull _target})
// updaten the attackLocation
If (IS_HASH(_target)) then {
    [_target] call FUNC(attackpos_update);
};

private _strategy = HASH_GET_DEF(_grouphash,"strategy",locationNull);
CHECK(!(isNull _strategy))

HASH_DELETE(_strategy);
HASH_SET(_grouphash,"strategy",locationNull);
