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
#include "script_component.hpp"

CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]],["_state","",[""]],["_target",nil,[objNull,[],locationNull],[2,3]],["_statementFinish","",[""]]];

_group = _group call CBA_fnc_getGroup;
private _grouphash = _group getVariable QGVAR(grouphash);

If !(_state in ["patrol","attack","defend","evade","idle","retreat","wait"]) then {_state = "idle";};
/// if there is no change in state, do nothing
If ((HASH_GET(_grouphash,"state") isEqualTo _state)&&(isNil "_target")) exitWith {};

HASH_SET(_grouphash,"state",_state);

If !(isNil "_target") then {
    HASH_SET(_grouphash,"target",_target);
};

[_group,_statementFinish] call FUNC(state_change);
