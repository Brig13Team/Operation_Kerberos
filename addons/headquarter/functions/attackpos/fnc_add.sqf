/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds an group to an attackposition
 *
 *  Parameter(s):
 *      0 : LOCATION - the attacklocation
 *      1 : GROUP - the group to be added
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]],["_group",grpNull,[grpNull]]];
CHECK((isNull _attackLoc)||(isNull _group)||{!(IS_HASH(_attackLoc))})
TRACEV_2(_attackLoc,_group);

// get the already registered groups
private _enemygroups = HASH_GET_DEF(_attackLoc,"enemygroups",[]);
TRACEV_1(_enemygroups);
// only add a group if it was not registered yet
If !(_group in _enemygroups) then {
    // add the group to the attacklocation
    _enemygroups pushBack _group;
    HASH_SET(_attackLoc,"enemygroups",_enemygroups);

    // get the playerhash
    private _grouphash = _group getVariable QGVAR(grouphash);
    If (isNil "_grouphash") then {
        // this should never been executed, just a failsafe
        [_group] call FUNC(registerPlayerGroup);
        _grouphash = _group getVariable QGVAR(grouphash);
    };
    [_attackLoc] call FUNC(attackpos_update);
};
