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

_this params ["_targetPos"];

private _towns = "(getText (_x >> 'type') in ['NameCityCapital','NameCity','NameVillage'])" configClasses (configFile >> "CfgWorlds" >> worldName >> "Names");

_towns = _towns call BIS_fnc_arrayShuffle;

private _return = [];

{
    private _pos = getArray(_x >> "position");
    If (
            ((_pos distance2D _targetPos) > 4000)&&
            (({(_x distance2D _pos)<3000} count allPlayers)<1)
        ) exitWith {
        _return = _pos;
    };
} forEach _towns;

If ((count (_return nearRoads 50))>0) then {
    _return = getPos ((_return nearRoads 50) select 0);
};

_return;
