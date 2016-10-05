/*
    Author: Dorbedo

    Description:
        registers a group of interest

    Parameter(s):
        0:Group <GROUP> - the group to be registered
        1:Type <STRING>

    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]],["_type","attack",[""]]];
CHECK((isNull _group)||(!(_type in ["attack","defence","patrol"])));

private _grouphash = HASH_CREATE;
private ["_key","_state"];
switch _type do {
    case "defence" : {
            _key = "defenceGroups";
            _state = "defend";
        };
    case "patrol" : {
            _key = "patrolGroups";
            _state = "patrol";
        };
    default {
            _key = "attackGroups";
            _state = "wait";
        };
};
HASH_GET(GVAR(groups),_key) pushBack _grouphash;
_group setVariable [QGVAR(grouphash),_grouphash];

HASH_SET(_grouphash,"grouptype",_type);
HASH_SET(_grouphash,"state",_state);

private _strenghtArray = (_group call FUNC(strengthAI)) params ["_GroupType","_value","_threat"];
HASH_SET(_grouphash,"type",_GroupType);
HASH_SET(_grouphash,"value",_value);
HASH_SET(_grouphash,"threat",_threat);
