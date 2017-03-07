/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a player group
 *
 *  Parameter(s):
 *      0 : GROUP - the group of players
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]]];
CHECK(isNull _group)

private _grouphash = _group getVariable QGVAR(grouphash);
If (isNil "_grouphash") then {
    _grouphash = HASH_CREATE;
    _group setVariable [QGVAR(grouphash),_grouphash];
    HASH_GET(GVAR(groups),"playergroups") pushBack _grouphash;

    private _strengthArray = (_group call FUNC(strengthPlayer)) params ["_GroupType","_value","_threat"];
    HASH_SET(_grouphash,"group",_group);
    HASH_SET(_grouphash,"type",_GroupType);
    HASH_SET(_grouphash,"value",_value);
    HASH_SET(_grouphash,"threat",_threat);

    HASH_SET(_grouphash,"typehistory",[]);
    HASH_SET(_grouphash,"valuehistory",[]);
    HASH_SET(_grouphash,"threathistory",[]);
};
