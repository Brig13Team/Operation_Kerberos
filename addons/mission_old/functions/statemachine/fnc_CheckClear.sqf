/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the clear check
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

private _list = HASH_GET_DEF(_mission,"list",(HASH_GET_DEF(_mission,"objects",[])));
private _distance = HASH_GET_DEF(_mission,"distance",500);
private _centerpos = HASH_GET(_mission,"centerpos");

TRACEV_4(_list,_distance,_centerpos,HASH_GET(_mission,'list'));

If (IS_CODE(_list)) then {_list = [] call _list};

If (({If ((alive _x)&&{(_x distance2D _centerpos) <= _distance}) exitWith {1};false;} count _list)>0) exitWith {
    /* the mission has not been finished */
};

_mission setVariable ["progress","succeeded"];
