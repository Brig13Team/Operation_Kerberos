/*
	Author: Dorbedo
	
	Description:
		register an artillery
	
	Parameter(s):
		0 : OBJECT	- Artillery to register
	
*/
#include "script_component.hpp"
SCRIPT(register);

params[["_newUnit",objNull,[objNull]]];

if (isNull _newUnit) exitWith {false};

If ((vehicle _newUnit) isKindOf "StaticMortar") exitWith {
	GVAR(fdc_mortars) pushBack [_newUnit,_position];
	true
};

private ["_mags","_ammo"];

_mags = getArtilleryAmmo [_newUnit];
_ammo = getText(configFile>>"CfgMagazines">> _mags >> "ammo");

If (_ammo isKindOf "R_230mm_HE") exitWith {
	GVAR(fdc_rocket) pushBack [_newUnit,_position];
	true
};

GVAR(fdc_artilleries) pushBack [_newUnit,_position];
true