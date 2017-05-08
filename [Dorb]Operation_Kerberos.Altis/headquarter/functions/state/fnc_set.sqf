/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sets the state of a group
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - The group/the group of a unit
 *      1 : STRING - The state in which to change
 *      2 : ARRAY/OBJECT - The target of the group
 *      3 : STRING - called on finishing the state
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]],["_state","",[""]],["_target",nil,[objNull,[],locationNull],[2,3]],["_statementFinish","",[""]]];
CHECK(isNull _group)

TRACEV_1(_this);
CHECK(true)
_group = _group call CBA_fnc_getGroup;
private _grouphash = _group getVariable QGVAR(grouphash);
//TRACEV_5(_group,_state,_target,_statementFinish,_grouphash);
If !(_state in ["patrol","attack","defend","evade","idle","retreat","wait"]) then {_state = "idle";};
/// if there is no change in state, do nothing
// If ((HASH_GET(_grouphash,"state") isEqualTo _state)&&(isNil "_target")) exitWith {};

#ifdef DEBUG_MODE_FULL
    If (isNil "_grouphash") then {
        TRACEV_4(_group,_grouphash,_state,_fnc_scriptMap);
    };
#endif

HASH_SET(_grouphash,"state",_state);

If !(isNil "_target") then {
    HASH_SET(_grouphash,"target",_target);
};

[_group,_statementFinish] call FUNC(state_change);
