/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a new group to the HQ
 *
 *  Parameter(s):
 *      0 : GROUP - the group to register
 *      1 : STRING - the type of group (attack,defence,patrol)
 *
 *  Returns:
 *      none
 *
 */
 #define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]],["_type","attack",[""]]];
TRACEV_2(_group,_type);
CHECK(isNull _group)
IF (!(_type in ["attack","defence","patrol"])) exitWith {
    ERROR("Wrong state");
};


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
private _grouphash = HASH_CREATE;
HASH_GET(GVAR(groups),_key) pushBack _grouphash;
_group setVariable [QGVAR(grouphash),_grouphash];
TRACEV_3(_group,_type,_grouphash);
HASH_SET(_grouphash,"grouptype",_type);
HASH_SET(_grouphash,"group",_group);
HASH_SET(_grouphash,"state",_state);

private _strenghtArray = (_group call FUNC(strengthAI)) params ["_GroupType","_value","_threat"];
HASH_SET(_grouphash,"type",_GroupType);
HASH_SET(_grouphash,"value",_value);
HASH_SET(_grouphash,"threat",_threat);
