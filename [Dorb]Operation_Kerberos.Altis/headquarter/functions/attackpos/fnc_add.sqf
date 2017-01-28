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
TRACEV_2(_attackLoc,_group);
private _enemygroups = HASH_GET_DEF(_attackLoc,"enemygroups",[]);
TRACEV_1(_enemygroups);

If !(_group in _enemygroups) then {
    _enemygroups pushBack _group;
    HASH_SET(_attackLoc,"enemygroups",_enemygroups);

    private _grouphash = _group getVariable QGVAR(grouphash);
    If (isNil "_grouphash") then {
        [_group] call FUNC(registerPlayerGroup);
        _grouphash = _group getVariable QGVAR(grouphash);
    };
    private _GroupType = HASH_GET(_grouphash,"type");
    private _value = HASH_GET(_grouphash,"value");
    private _threat = HASH_GET(_grouphash,"threat");

    private _currentType = HASH_GET_DEF(_attackLoc,"enemytype",[ARR_3(0,0,0)]);
    private _currentValue = HASH_GET_DEF(_attackLoc,"enemyvalue",[ARR_3(0,0,0)]);
    private _currentThreat = HASH_GET_DEF(_attackLoc,"enemythreat",[ARR_3(0,0,0)]);

    _currentType set [_GroupType,(_currentType select _GroupType) + 1];
    _currentValue set [_GroupType,(_currentValue select _GroupType) + _value];

    _currentThreat = [
        (_currentThreat select 0) max (_threat select 0),
        (_currentThreat select 1) max (_threat select 1),
        (_currentThreat select 2) max (_threat select 2)
    ];

    HASH_SET(_attackLoc,"enemytype",_currentType);
    HASH_SET(_attackLoc,"enemyvalue",_currentValue);
    HASH_SET(_attackLoc,"enemythreat",_currentThreat);
}else{
    [_attackLoc] call FUNC(attackpos_update);
};
