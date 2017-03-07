/*
 *  Author: Dorbedp
 *
 *  Description:
 *      creates helper for designing Roads
 *
 *  Parameter(s):
 *      0 : ARRAY/OBJECT - Centerposition
 *      1 : SCALAR - Size (0-small/1-mid/2-big)
 *      2 : SCALAR - Direcetion
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_center",[],[[],objNull]],["_type",0,[0]],["_dir",0,[0]]];

If (IS_OBJECT(_center)) then {
    _dir = getDir _center;
    _center = getPos _center;
};


private ["_arrow_side","_arrow_dir","_distance"];
switch _type do {
    case 1 : {
        _arrow_side = "Sign_Arrow_Large_Pink_F";
        _arrow_dir = "Sign_Arrow_Direction_Pink_F";
        _distance = 5.5;
    };
    case 2 : {
        _arrow_side = "Sign_Arrow_Large_Green_F";
        _arrow_dir = "Sign_Arrow_Direction_Green_F";
        _distance = 6.5;
    };
    default {
        _arrow_side = "Sign_Arrow_Large_Yellow_F";
        _arrow_dir = "Sign_Arrow_Direction_Yellow_F";
        _distance = 3.5;
    };
};


private _leftPos = [_center, _distance, _dir + 90] call BIS_fnc_relPos;
private _rightPos = [_center, _distance, _dir - 90] call BIS_fnc_relPos;

for "_i" from 0 to 30 do {
    (createVehicle [_arrow_dir,([_center, _i, _dir] call BIS_fnc_relPos), [], 0, "CAN_COLLIDE"]) setDir _dir;
    (createVehicle [_arrow_side,([_rightPos, _i, _dir] call BIS_fnc_relPos), [], 0, "CAN_COLLIDE"]) setDir _dir;
    (createVehicle [_arrow_side,([_leftPos, _i, _dir] call BIS_fnc_relPos), [], 0, "CAN_COLLIDE"]) setDir _dir;
};
