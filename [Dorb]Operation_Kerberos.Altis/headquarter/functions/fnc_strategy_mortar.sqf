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
_this params ["_currentLogic","_currenttroopsNeeded"];

private _currentPosition = getPosATL _currentLogic;

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

private _amount = (floor(_currenttroopsNeeded / 2))max 2;
private _return = 15;
if (_currenttroopsNeeded > 20) then {
    _return = 40;
    _amount = 10;
};

[_currentPosition,1,_amount] call FUNC(fdc_placeOrder);
[QUOTE(_this call FUNC(attackpos_remove)),[_currentLogic],200] call EFUNC(common,waitandexec);

_return;


