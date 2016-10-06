/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deaktivated a waypoint
 *
 *  Parameter(s):
 *      0 : STRING - the key of the waypoint to deaktivate
 *      1 : BOOL - deaktivate (true) , false to aktivate
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params[
    ["_key","",[""]],
    ["_deaktivate",true,[true]];
    ];
CHECK(_key isEqualTo "");
If (_deaktivate) then {
    HASH_SET(GVAR(waypoints),_key,999999);
    HASH_GET(GVAR(waypoints),"deaktivated") pushBack _key;
}else{
    HASH_SET(GVAR(waypoints),_key,0);
    private _deaktivatedWP = HASH_GET(GVAR(waypoints),"deaktivated");
    _deaktivatedWP = _deaktivatedWP - [_key];
    HASH_SET(GVAR(waypoints),"deaktivated",_deaktivatedWP);
};
