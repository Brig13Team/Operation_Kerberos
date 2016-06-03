/*
    Author: iJesuz

    Description:
        towing

    Parameter(s):
        0 : OBJECT - vehicle 1
        1 : OBJECT - vehicle 2
*/
#include "script_component.hpp"

_this params [["_veh1",objNull,[objNull]],["_veh2",objNull,[objNull]]];

if ((isNull _veh1) || (isNull _veh2)) exitWith {};

detach _veh2;
private _index = _veh1 getVariable [QGVAR(towEventHandler),[]];

{
    _veh1 removeEventHandler _x;
} forEach _index;

_veh1 setVariable [QGVAR(towArray), nil];
_veh1 setVariable [QGVAR(towIndex), nil];
_veh1 setVariable [QGVAR(towEventHandler), nil];
_veh1 setVariable [QGVAR(towedVehicle), nil];
