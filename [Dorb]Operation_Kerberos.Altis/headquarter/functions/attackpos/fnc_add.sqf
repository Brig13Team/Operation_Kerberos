/*
 *  Author: Dorbedo
 *
 *  Description:
 *      add a enemygroup to an attackposition
 *
 *  Parameter(s):
 *      0 : LOCATION - the attacklocation
 *      1 : GROUP - the group
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]],["_group",grpNull,[grpNull]]];
CHECK((isNull _attackLoc)||(isNull _group)||{!(IS_HASH(_attackLoc))})

private _enemygroups = HASH_GET(_attackLoc,"enemygroups");

If !(_group in _enemygroups) then {
    _enemygroups pushBack _group;
    HASH_SET(_attackLoc,"enemygroups",_enemygroups);

    private _grouphash = _group getVariable QGVAR(grouphash);
    If (isNil _grouphash) then {
        [_group] call FUNC(registerPlayerGroup);
        _grouphash = _group getVariable QGVAR(grouphash);
    };
    private _GroupType = HASH_GET(_grouphash,"type");
    private _value = HASH_GET(_grouphash,"value");
    private _threat = HASH_GET(_grouphash,"threat");

    private _currentType = HASH_GET(_attackLoc,"enemytype");
    private _currentValue = HASH_GET(_attackLoc,"enemyvalue");
    private _currentThreat = HASH_GET(_attackLoc,"enemythreat");

    _currentType set [_GroupType,(_GroupType select _GroupType) + 1];
    _currentValue set [_GroupType,(_currentValue select _GroupType) + _value];

    _currentThreat = [
        (_currentThreat select 0) max (_threat select 0),
        (_currentThreat select 1) max (_threat select 1),
        (_currentThreat select 2) max (_threat select 2)
    ];

    HASH_SET(_attackLoc,"enemytype",_GroupType);
    HASH_SET(_attackLoc,"enemyvalue",_value);
    HASH_SET(_attackLoc,"enemythreat",_threat);
}else{
    [_attackLoc] call FUNC(attackpos_update);
};
