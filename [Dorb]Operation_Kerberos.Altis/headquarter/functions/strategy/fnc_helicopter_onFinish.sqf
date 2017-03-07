/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onFinished Event
 *
 *  Parameter(s):
 *      0 : OBJECT - Attackhelicopter
 *      1 : GROUP - Attackgroup
 *      2 : ARRAY - spawnposition
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_attackVeh","_attackGroup","_spawnpos"];
TRACEV_3(_attackVeh,_attackGroup,_spawnpos);
If (canMove _attackVeh) then {
    [_attackGroup] call CBA_fnc_clearWaypoints;
    [_attackGroup,_spawnPos,200,"MOVE","SAFE","WHITE","FULL"] call CBA_fnc_addWaypoint;
    _attackVeh domove _spawnpos;
    [
        {
            (_this select 0) params ["_attackVeh","_spawnpos"];
            If (((_attackVeh distance2D _spawnpos) > 400)&&(canMove _attackVeh)) exitWith {};
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            {deletevehicle _x} foreach crew _attackVeh;
            deletevehicle _attackVeh;
        },
        30,
        [_attackVeh,_spawnPos]
    ] call CBA_fnc_addPerFrameHandler;
}else{
    {_x setDamage 1;} foreach units _attackGroup;
};
