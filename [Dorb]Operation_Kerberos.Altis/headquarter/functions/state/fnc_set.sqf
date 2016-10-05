/*
    Author: Dorbedo

    Description:
        sets the group attributes

    Parameter(s):
        0 : Group - <GROUP>
        1 : Next state - <STRING>
        2 : The Target of the state as Object or positions (2D/3D) <OBJECT/ARRAY>
        3 : Statement to be called after finishing the waypoint <STRING>

    Returns:
        none
*/
#include "script_component.hpp"
CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]],["_state","",[""]],["_target",nil,[objNull,[]],[2,3]],["_statementFinish","",[""]]];

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
