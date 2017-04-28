/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onFinished Event
 *
 *  Parameter(s):
 *      0 : OBJECT - AirUnit
 *      1 : GROUP - Attackgroup
 *      2 : ARRAY - spawnposition
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_attackVeh","_attackGroup","_spawnpos","_attackLoc"];
TRACEV_3(_attackVeh,_attackGroup,_spawnpos);
If (canMove _attackVeh) then {
    [_attackGroup] call CBA_fnc_clearWaypoints;
    [_attackGroup,_spawnPos,200,"MOVE","CARELESS","WHITE","FULL"] call CBA_fnc_addWaypoint;
    _attackVeh domove _spawnpos;
    [
        {
            (!(alive (_this select 0)))||(((_this select 0) distance2D (_this select 2))<200)
        },
        {
            [(_this select 0),units (_this select 1),(_this select 1)] call EFUNC(common,delete);
        },
        [_attackVeh,_attackGroup,_spawnpos,_attackLoc],
        (5*60),
        {
            [(_this select 0),units (_this select 1),(_this select 1)] call EFUNC(common,delete);
        }
    ] call CBA_fnc_waitUntilAndExecute;
}else{
    {_x setDamage 1;} foreach units _attackGroup;
    [_attackGroup] call EFUNC(common,delete);
};
