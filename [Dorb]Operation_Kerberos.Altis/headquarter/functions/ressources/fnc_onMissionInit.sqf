/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sets the values after the mission has started
 *
 *  Parameter(s):
 *      0 : LOCATION - the missionhash
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

//if (HASH_HASKEY(_mission, "side")) exitWith { -1 };

{
    private _curRes = _x;
    private _curResHash = HASH_GET(GVAR(ressources),_curRes);
    HASH_SET(_curResHash,"nextexecution",-1);
    HASH_SET(_curResHash,"units",[]);
} forEach HASH_KEYS(GVAR(ressources));
