/*
	Author: Dorbedo
	
	Description:
		register an artillery
	
	Parameter(s):
		0 : OBJECT	- Artillery to register
	
*/
#include "script_component.hpp"
SCRIPT(register);

If (isNil QGVAR(fdc_logic)) then {
	[] call FUNC(fdc_init);
};

params[["_newUnit",objNull,[objNull]]];
private "_temp";
If ((vehicle _newUnit) isKindOf "StaticMortar") exitWith {
	_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]);
	_temp pushBack [_newUnit,_position];
	SETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),_temp);
};
private ["_mags","_ammo","_isRocket"];

_mags = getArtilleryAmmo [cursorTarget];
_ammo = getText(configFile>>"CfgMagazines">> _mags >> "ammo");
_isRocket = (_ammo isKindOf "R_230mm_HE");

If (_isRocket) exitWith {
	_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]);
	_temp pushBack [_newUnit,_position];
	SETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),_temp);
};
_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]);
_temp pushBack [_newUnit,_position];
SETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),_temp);
