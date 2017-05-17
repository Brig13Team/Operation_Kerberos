/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn civilian cars inside of garages
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *      1 : SCALAR - amount
 *      2 : SCALAR - radius
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_amount",0,[0]],["_radius",200,[0]]];

private _garages = (_centerPosition nearObjects ["Land_i_Garage_V1_F", _radius]);// + (_centerPosition nearObjects ["Land_i_Garage_V2_F", _radius]);
_garages = _garages - GVAR(targetHouses);
_garages = _garages - GVAR(usedHouses);

_garages = _garages call BIS_fnc_arrayshuffle;
_garages resize (((count _garages) min _amount) max 0);

{
    private _unittype = ["civcar"] call FUNC(getUnit);
    private _curGarage = _x;
    private _spawndir = getDir _curGarage;
    private _spawnpos = getPosATL _curGarage;
    _spawnpos set [2,(_spawnpos select 2) + 0.5];
    private _veh = createVehicle [_unittype,[0,0,0],[],0,"CAN_COLLIDE"];
    _veh setPosATL _spawnpos;
    _veh setDir _spawndir;
    #ifdef DEBUG_MODE_FULL
        [_spawnpos,"Garage","ColorCivilian"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _garages;
