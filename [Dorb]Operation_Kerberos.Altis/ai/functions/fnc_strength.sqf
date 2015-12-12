/*
	Author: Dorbedo
	
	Description:
		updates_strength
		do not call directly
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(update_strength);
_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {["",0]};

_value = 0;
_all_Vehicles = [];
{
	If !(_x in _all_Vehicles) then {
		_all_Vehicles pushBack _x;
	};
	If !((vehicle _x) in _all_Vehicles) then {
		_all_Vehicles pushBack (vehicle _x);
	};
}forEach (units _group);
_type = "Infanterie";
{
	_value = _value + (switch (true) do {
		case (_x isKindOf "Air") : {
			If ((toLower(getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation")))in ["helicopterrtd","helicopterx"]) then {
				_type = "Helicopter";15
			}else{
				_type = "Plane";20
			};
		};
		case (_x isKindOf "Armored") : {_type = "Armored";15};
		case (_x isKindOf "Autonomous") : {_type = "Autonomous";15};
		case (_x isKindOf "Car") : {_type = "Car";15};
		case (_x isKindOf "Ship") : {_type = "Ship";15};
		default {1};
	});
} forEach _all_Vehicles;

[_type,_value]