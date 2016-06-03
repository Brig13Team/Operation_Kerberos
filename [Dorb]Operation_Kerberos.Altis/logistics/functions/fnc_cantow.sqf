/*
    Author: iJesuz, Dorbedo

    Description:
        checks if a vehicle can tow something

    Parameter(s):
        0 : OBJECT - target of the ace action
*/
#include "script_component.hpp"
_this params [["_target",objNull,[objNull]]];
If !((_target isKindOf "Car")||(_target isKindOf "Tank")) exitWith {false};
private _boundingBox1 = boundingBoxReal _target;
private _target_lenght = abs(_boundingBox1 select 1 select 0);

private _position = (getPos _target) vectorAdd ((vectorDir _target) vectorMultiply (-1 * _target_lenght));
private _nearVehicles = _position nearEntities [["Tank","Car","Plane"],15];

private _return = true;
{
    If ((_x != _target)&&{
        (
            _position distance2D (
                (getPos _x) vectorAdd ((vectorDir _x) vectorMultiply (abs((boundingBoxReal _x) select 0 select 0)))
            )< 2
        )
    }) exitWith {_return = true;};
} forEach _nearVehicles;

_return;