/*
 *  Author: Dorbedo
 *
 *  Description:
 *      changes the state of a group
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - The group/the group changes it's state
 *      1 : STRING - The statement wich is called on finishing the state
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]],["_statementFinish","",[""]]];

_group = _group call CBA_fnc_getGroup;

private _grouphash = _group getVariable QGVAR(grouphash);
If (isNil "_grouphash") then {
    ERROR("Group not registered");
    [_group,'patrol'] call FUNC(registerGroup);
};
/// update the strength if the unit received some losses or if the unit lost the vehicle
private _strengthArray = ([_group] call FUNC(getstrengthAIGroup)) params ["_value","_strength","_defence","_grouptype"];
HASH_SET(_grouphash,"type",_grouptype);
HASH_SET(_grouphash,"value",_value);
HASH_SET(_grouphash,"defence",_defence);
HASH_SET(_grouphash,"strength",_strength);

private _state = HASH_GET(_grouphash,"state");

switch (_state) do {
    case "patrol" : {
            private _formation = selectRandom ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"];
            private _position = HASH_GET(_grouphash,"target");
            If (isNil "_position") then {_position = getPos (leader _group)};
            If (IS_LOCATION(_position)) then {_position = locationPosition _position;};
            [_group, _position, "AWARE", "WHITE", "NORMAL", "NO CHANGE", "", [5,10,15],50] call EFUNC(spawn,patrol_task);
        };
    default {[_group,_statementFinish] call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_state),_state],{}]);};
};
