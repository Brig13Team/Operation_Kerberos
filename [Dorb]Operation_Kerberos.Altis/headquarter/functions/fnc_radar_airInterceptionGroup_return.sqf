/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a air-InterceptionGroup
 *
 *  Parameter(s):
 *      0 : OBJECT - AI-Plane
 *      1 : OBJECT - AI-Plane
 *      2 : GROUP - AI-GROUP
 *      3 : ARRAY - Pos to return to
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_attackVeh","_attackVeh2","_attackGroup","_spawnpos"];

//TRACEV_4(_attackVeh,_attackVeh2,_attackGroup,_spawnpos);

[_attackGroup] call CBA_fnc_clearWaypoints;
[_attackGroup,_spawnPos,200,"MOVE","CARELESS","WHITE","FULL"] call CBA_fnc_addWaypoint;

[
    {
        ({(_x distance2D (_this select 3))<1000} count [_this select 0,_this select 1])>0;
    },
    {
        // reduce the respawn timer by 5 Minutes for each plane which is alive
        //TRACE("PLANES RETURNED");
        GVAR(radar_nextAI) = GVAR(radar_nextAI) - 5 * 60 * ({alive _x} count [_this select 0,_this select 1]);
        [_this select 0, _this select 1,_this select 2] call EFUNC(common,delete);
    },
    _this,
    (5*60),
    {
        [_this select 0, _this select 1,_this select 2] call EFUNC(common,delete);
    }
] call CBA_fnc_waitUntilAndExecute;
