/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn civilian Vehicles on roads in an area
 *
 *  Parameter(s):
 *      0 : ARRAY - Roadlist
 *      1 : SCALAR - amount
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_roadlist",[],[[]]],["_amount",0,[0]]];
private _roadsReturn =+ _roadlist;
_roadlist = _roadlist call BIS_fnc_arrayshuffle;
_roadlist resize (((count _roadlist) min _amount) max 0);

{
    private _unittype = ["civvehicle"] call FUNC(getUnit);
    private _distance = switch ((_x select 2)) do {
        case 1 : {4.5};
        case 2 : {5.5};
        default {3.5};
    };
    private _dir = [(_x select 1)+90,(_x select 1)-90] select (floor(random 2));
    private _spawnpos = (_x select 0) getPos [_distance,_dir];
    [_spawnpos,civilian,_unittype,(_x select 1),false,true] call FUNC(vehicle);
    #ifdef DEBUG_MODE_FULL
        [_spawnpos,"","ColorCivilian","b_motor_inf"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _roadlist;

private _ret = _roadsReturn - _roadlist;
TRACEV_1(_ret);
_ret
