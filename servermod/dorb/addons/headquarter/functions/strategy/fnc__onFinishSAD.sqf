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

If (IS_GROUP(_attackpos)) then {
    private _group = _attackpos;
    _attackpos = _group getVariable [QGVAR(target),locationNull];
    _group setVariable [QGVAR(target),locationNull];
    private _stategy = _group getVariable [QGVAR(strategy),locationNull];
    if !(isNull _stategy) then {
        HASH_DELETE(_strategy);
    };
};

CHECK(isNull _attackpos)

[_attackpos] call FUNC(attackpos_delete);
