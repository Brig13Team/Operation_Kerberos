/*
    Author: iJesuz

    Description:
        towing

    Parameter(s):
        0 : OBJECT - vehicle 1
        1 : OBJECT - vehicle 2
*/
#include "script_component.hpp"
#define BUFFER 3
_this params [["_veh1",objNull,[objNull]],["_veh2",objNull,[objNull]]];

if ((isNull _veh1) || (isNull _veh2)) exitWith {};

private _boundingBox1 = boundingBoxReal _veh1;
private _boundingBox2 = boundingBoxReal _veh2;
private _l1 = abs(_boundingBox1 select 1 select 0);
private _l2 = abs(_boundingBox2 select 0 select 0);

_veh2 attachTo [_veh1,[0,-1 * (_l1 + _l2 + BUFFER),0]];
_veh2 setDir 0;

_veh1 setVariable [QGVAR(towedVehicle),_veh2,true];

if (player == (driver _veh1)) then {
    [_veh1,_veh2] spawn FUNC(tow);
};

private _aindex = [];
private _index = _veh1 addEventHandler ["GetIn", {
    if ((_this select 1) isEqualTo "driver") then {
        [_this select 0, (_this select 0) getVariable [QGVAR(towedVehicle), objNull]] spawn FUNC(tow);
    };
}];
_aindex pushBack ["GetIn",_index];

_index = _veh1 addEventHandler ["SeatSwitched", {
    if ((assignedVehicleRole (_this select 1)) isEqualTo ["driver"]) then {
        [_this select 0, (_this select 0) getVariable [QGVAR(towedVehicle), objNull]] spawn FUNC(tow);
    };
}];
_aindex pushBack ["SeatSwitched",_index];

_veh1 setVariable [QGVAR(towEventHandler),_aindex,true];
