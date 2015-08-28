/*
	Author: Dorbedo
	
	Description:
		register an artillery
	
	Parameter(s):
		0 : OBJECT	- Artillery to register
	
*/
#include "script_component.hpp"
SCRIPT(fdc_register);

If (isNil "DORB_FDC_LOGIC") then {
	[] call FUNC(fdc_init);
};

params[["_newUnit",objNull,[objNull]]];
private "_temp";
If ((vehicle _newUnit) isKindOf "StaticMortar") exitWith {
	_temp = GETVAR(DORB_FDC_LOGIC,DORB_FDC_MORTARS,[]);
	_temp pushBack [_newUnit,_position];
	SETVAR(DORB_FDC_LOGIC,DORB_FDC_MORTARS,_temp);
};
private ["_mags","_ammo","_isRocket"];

_mags = getArtilleryAmmo [cursorTarget]
_ammo = getText(configFile>>"CfgMagazines">> _mags >> "ammo");
_isRocket = (_ammo isKindOf "R_230mm_HE");

If (_isRocket) exitWith {
	_temp = GETVAR(DORB_FDC_LOGIC,DORB_FDC_ROCKET,[]);
	_temp pushBack [_newUnit,_position];
	SETVAR(DORB_FDC_LOGIC,DORB_FDC_ROCKET,_temp);
};
_temp = GETVAR(DORB_FDC_LOGIC,DORB_FDC_ARTILLERIES,[]);
_temp pushBack [_newUnit,_position];
SETVAR(DORB_FDC_LOGIC,DORB_FDC_ARTILLERIES,_temp);
