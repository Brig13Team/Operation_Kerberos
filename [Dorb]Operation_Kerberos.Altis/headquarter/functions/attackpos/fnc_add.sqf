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
    /*
    private _GroupType = HASH_GET(_grouphash,"type");
    private _value = HASH_GET(_grouphash,"value");
    private _threat = HASH_GET(_grouphash,"threat");

    // the type of the playerunits
    private _currentType = HASH_GET_DEF(_attackLoc,"enemytype",[ARR_3(0,0,0)]);
    // the strength of the playerunits depending on the type
    private _currentValue = HASH_GET_DEF(_attackLoc,"enemyvalue",[ARR_3(0,0,0)]);
    // the threat to possible AI attacks (e.g. strong AT/AA) -> needed for the choosing of the strategie
    private _currentThreat = HASH_GET_DEF(_attackLoc,"enemythreat",[ARR_3(0,0,0)]);

    // TODO -  the grouptype should support mixed groups, not only the strongest type
    _currentType set [_GroupType,(_currentType select _GroupType) + 1];
    _currentValue set [_GroupType,(_currentValue select _GroupType) + _value];
    // the highest threat is chosen (max [1,1,1])
    _currentThreat = [
        (_currentThreat select 0) max (_threat select 0),
        (_currentThreat select 1) max (_threat select 1),
        (_currentThreat select 2) max (_threat select 2)
    ];
    // set the values
    HASH_SET(_attackLoc,"enemytype",_currentType);
    HASH_SET(_attackLoc,"enemyvalue",_currentValue);
    HASH_SET(_attackLoc,"enemythreat",_currentThreat);
    */
};
