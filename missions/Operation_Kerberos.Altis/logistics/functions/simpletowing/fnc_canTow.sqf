/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      the vehicle can tow something
 *
 *  Parameter(s):
 *      0 : OBJECT - the vehicle
 *
 *  Returns:
 *      BOOL - the vehicle can be attached
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];

If ((isNull _target)||{!(alive _target)}||{!((_target isKindOf "Car")||(_target isKindOf "Tank"))}||{!((attachedObjects _target) isEqualTo [])}) exitWith {false};
private _boundingBox1 = boundingBoxReal _target;
private _target_lenght = abs(_boundingBox1 select 1 select 0);

private _position = (getPosASL _target) vectorAdd ((vectorDir _target) vectorMultiply (-1 * _target_lenght));
private _nearVehicles = _position nearEntities [["Tank","Car","Plane"],15];

private _return = false;
{
    TRACEV_3(typeOf _x,_position,(getPosASL _x) vectorAdd ((vectorDir _x) vectorMultiply (abs((boundingBoxReal _x) select 0 select 0))));
    If ((_x != _target)&&{
        (
            _position distance2D (
                (getPosASL _x) vectorAdd ((vectorDir _x) vectorMultiply (abs((boundingBoxReal _x) select 0 select 0)))
            )< 2
        )
    }&&{
        (crew _x) isEqualTo []
    }&&{
        (attachedObjects _x) isEqualTo []
    }&&{
        alive _x
    }
    ) exitWith {_return = true;};
} forEach _nearVehicles;

_return;
