/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Dorbedo
 *
 *  Parameter(s):
 *      0 : ARRAY - TargetPos
 *
 *  Returns:
 *      ARRAY - save spawnpos
 *
 */
#include "script_component.hpp"

_this params ["_targetPos",["_vehicletype","",[""]]];

private _towns = configProperties [(configFile >> "CfgWorlds" >> worldName >> "Names"),"(getText (_x >> 'type') in ['NameCityCapital','NameCity','NameVillage'])",true];

_towns = _towns call BIS_fnc_arrayShuffle;

private _return = [];

{
    private _pos = getArray(_x >> "position");
    If (
            ((_pos distance2D _targetPos) > 4000)&&
            ((_pos distance2D _targetPos) < 10000)&&
            (({(_x distance2D _pos)<3000} count allPlayers)<1)
        ) exitWith {
        _return = _pos;
    };
} forEach _towns;

_return set [2,0];
_return = [_return,200,0] call EFUNC(common,pos_random);

If ((count (_return nearRoads 50))>0) then {
    _return = getPos ((_return nearRoads 50) select 0);
};

If ((!(_vehicletype isEqualTo ""))&&{isClass(configfile>>"CfgVehicles">>_vehicletype)}) then {
    private _temp = _return findEmptyPosition [0,30,_vehicletype];
    If !(_temp isEqualTo []) then {
        _return = _temp;
    };
};

_return;
