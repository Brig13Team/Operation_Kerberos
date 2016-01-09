/*
    Author: iJesuz

    Description:
        towing

    Parameter(s):
        0 : OBJECT - vehicle 1
        1 : OBJECT - vehicle 2
*/
#include "script_component.hpp"
SCRIPT(canTow);

private ["_boundingBox1","_boundingBox2"];
params [["_veh1",objNull,[objNull]],["_veh2",objNull,[objNull]]];

if ((isNull _veh1) || (isNull _veh2)) exitWith {};

_boundingBox1 = boundingBoxReal _veh1;
_boundingBox2 = boundingBoxReal _veh2;
_l1 = abs(_boundingBox1 select 1 select 0);
_l2 = abs(_boundingBox2 select 0 select 0);

if (((_veh1 distance2D _veh2) - (_l1 + _l2)) <= 1) then {
	true;
} else {
	false;
}