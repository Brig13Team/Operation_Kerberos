/*
	Author: Dorbedo
	
	Description:
		ads a vakue to the Dangeraray when a unit git killed
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(killed);
private ["_killerpos","_x_pos","_y_pos","_value"];

_this params ["_killer","_caller"];
TRACEV_2(_killer,_caller);

_killerpos = _caller gethidefrom _killer

If ((_killerpos distance [0,0,0])<1) exitWith {};

_x_pos = floor(_killerpos - (GVAR(HQ_centerpos) select 0 - 2000));
_y_pos = floor((GVAR(HQ_centerpos) select 0 + 2000) - _killerpos);

CHECK((_x_pos<0)||(_y_pos<0))

_value = switch (true) do {
	case ((vehicle _killer)isKindOf "Armored") : {10}
	case ((vehicle _killer)isKindOf "Car") : {8}
	case ((vehicle _killer)isKindOf "Ship_F") : {6}
	case ((vehicle _killer)isKindOf "Air") : {12}
	default : {4}
};

GVAR(hq_buffer) pushBack [_x_pos,_y_pos,_value];
