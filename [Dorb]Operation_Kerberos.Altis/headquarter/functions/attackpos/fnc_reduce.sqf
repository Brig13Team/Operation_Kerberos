/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a group from a attackpoistion
 *
 *  Parameter(s):
 *      0 : LOCATION - the attack location
 *      1 : GROUP - the group to remove from the location
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]],["_group",grpNull,[grpNull]]];
CHECK((isNull _attackLoc)||(isNull _group)||{!(IS_HASH(_attackLoc))})

private _enemygroups = HASH_GET_DEF(_attackLoc,"enemygroups",[]);
If (_enemygroups isEqualTo []) exitWith {[_attackLoc] call FUNC(attackpos_delete);};

If (_group in _enemygroups) then {

    _enemygroups = _enemygroups - [_group];
    HASH_SET(_attackLoc,"enemygroups",_enemygroups);

    [_attackLoc] call FUNC(attackpos_update);
};
