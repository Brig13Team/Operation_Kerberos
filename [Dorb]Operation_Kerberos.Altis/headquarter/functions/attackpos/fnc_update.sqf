/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the enemystrenght at attacklocation
 *      doesn't change the attacking values
 *
 *  Parameter(s):
 *      0 : LCOATION - the attacklocation
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]]];
CHECK((isNull _attackLoc)||{!(IS_HASH(_attackLoc))})

private _enemygroups = HASH_GET(_attackLoc,"enemygroups");
private _groupsToRemove = [];

private _enemyType = [0,0,0];
private _enemyValue = [0,0,0];
private _enemyThreat = [0,0,0];

{
    private _currentGroup = _x;
    If (isNull _currentGroup) then {
        _groupsToRemove pushBack _currentGroup;
    }else{
        private _grouphash = _currentGroup getVariable QGVAR(grouphash);

        private _currentType = HASH_GET(_grouphash,"type");
        private _currentValue = HASH_GET(_grouphash,"value");
        private _currentThreat = HASH_GET(_grouphash,"threat");

        _enemyType set [_currentType,(_enemyType select _currentType) + 1];
        _enemyValue set [_currentType,(_enemyValue select _currentType) + _currentValue];
        _enemyThreat = [
            (_enemyThreat select 0) max (_currentThreat select 0),
            (_enemyThreat select 1) max (_currentThreat select 1),
            (_enemyThreat select 2) max (_currentThreat select 2)
        ];
    };
} forEach _enemygroups;

{
    _enemygroups = _enemygroups - [_x];
} forEach _groupsToRemove;

HASH_SET(_attackLoc,"enemygroups",_enemygroups);
HASH_SET(_attackLoc,"enemytype",_enemyType);
HASH_SET(_attackLoc,"enemyvalue",_enemyValue);
HASH_SET(_attackLoc,"enemythreat",_enemyThreat);
