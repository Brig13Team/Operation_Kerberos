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

_this params ["_attackPos"];
CHECK(isNull _groupleader)

private _group = [_groupleader] call CBA_fnc_getGroup;
private _target = _group getVariable [QGVAR(target),locationNull];
[_target] call FUNC(attackpos_delete);
_group setVariable [QGVAR(target),locationNull];

private _stategy = _group getVariable [QGVAR(strategy),locationNull];
CHECK(!(isNull _strategy))
HASH_DELETE(_strategy);
