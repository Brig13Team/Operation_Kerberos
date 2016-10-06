/*
    Author: Dorbedo

    Description:
        reduces a attackPos

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params [["_attackLoc",locationNull,[locationNull]],["_group",grpNull,[grpNull]]];
CHECK((isNull _attackLoc)||(isNull _group)||{!(IS_HASH(_attackLoc))})

private _enemygroups = HASH_GET(_attackLoc,"enemygroups");

If (_group in _enemygroups) then {

    _enemygroups = _enemygroups - [_group];
    HASH_SET(_attackLoc,"enemygroups",_enemygroups);

    [_attackLoc] call FUNC(attackpos_update);
};
