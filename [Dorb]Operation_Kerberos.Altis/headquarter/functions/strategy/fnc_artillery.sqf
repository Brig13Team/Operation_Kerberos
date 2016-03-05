/*
    Author: Dorbedo
    
    Description:
        revon
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params ["_currentLocation","_currenttroopsNeeded"];

private _currentPosition = getPosATL _currentLocation;

private _nearUnits = _currentPosition nearEntities [["CAManBase","Car","Tank"], 100];

private _nearestPos = _currentPosition;
private _distance = 900;
private _dir = random(360);
{
    If ((side _x == GVARMAIN(playerside))&&{((_x distance2D _currentPosition)< _distance)}) then {
        _distance = _x distance2D _currentPosition;
        _nearestPos = getPosATL _x;
        _dir = getDir _x;
    };
} forEach _nearUnits;

private _return = 15;
private _special = [];
private _amount = (floor(_currenttroopsNeeded / 2))max 10;
if (_currenttroopsNeeded > 30) then {
    _return = 50;
    _special = ["creeping",_dir,50,200];
};

[_currentPosition,0,_amount,_special] call FUNC(fdc_placeOrder);
[QUOTE(_this call FUNC(attackpos_remove)),[_currentLocation],200] call EFUNC(common,waitandexec);

_return;


