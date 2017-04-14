/**
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

    private _strengthArray = (_group call FUNC(strengthPlayer)) params ["_value","_strenght","_defence","_grouptype"];
    HASH_SET(_grouphash,"group",_group);
    HASH_SET(_grouphash,"value",_value);
    HASH_SET(_grouphash,"strenght",_strenght);
    HASH_SET(_grouphash,"defence",_defence);
    HASH_SET(_grouphash,"type",_grouptype);

    HASH_SET(_grouphash,"valuehistory",[]);
    HASH_SET(_grouphash,"strenghthistory",[]);
    HASH_SET(_grouphash,"defencehistory",[]);
    HASH_SET(_grouphash,"typehistory",[]);
};
