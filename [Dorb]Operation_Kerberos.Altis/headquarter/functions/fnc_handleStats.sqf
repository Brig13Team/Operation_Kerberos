/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports the stats to DB
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


private _temp = GVAR(stats);
GVAR(stats) = HASH_CREATE;

{
    private _playerID = _x;
    private _stats = HASH_GET(_temp,_playerID);
    ["addPlayerStats",_playerID,_stats select 0,_stats select 1,_stats select 2] call DB_SEND;
} forEach HASH_KEYS(_temp);
