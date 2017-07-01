/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the vehicle is towed
 *
 *  Parameter(s):
 *      0 : OBJECT - the vehicle to tow
 *
 *  Returns:
 *      BOOL - it can be untowed
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];

// just recheck, if something happend
//CHECK([_target] call FUNC(simpletowing_canTow));

// get the vehicle
private _boundingBox1 = boundingBoxReal _target;
private _target_lenght = abs(_boundingBox1 select 1 select 0);
private _position = (getPosASL _target) vectorAdd ((vectorDir _target) vectorMultiply (-1 * _target_lenght));
TRACEV_2(getPos _target,_position);
private _nearVehicles = _position nearEntities [["Tank","Car","Plane"],15];

private _partner = objNull;
{
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
    ) exitWith {_partner = _x;};
} forEach _nearVehicles;
TRACEV_2(_partner,_nearVehicles);
CHECK(isNull _partner);
_partner setVariable [QGVAR(towingPartner),_target,true];
_target setVariable [QGVAR(towingPartner),_partner,true];
_partner lock 3;

private _boundingBox2 = boundingBoxReal _partner;
private _partner_lenght = abs(_boundingBox2 select 1 select 0);

//private _height = (((getPosASL _partner) select 2) - ((getPosATL _partner) select 2))-(((getPosASL _target)select 2) - ((getPosATL _target)select 2));
private _height = ( ((getPosWorld _partner) select 2) - ((getPosWorld _target)select 2) );

private _offset = [0,-1*(_target_lenght+_partner_lenght),_height];


_partner attachTo [_target,_offset];


//
