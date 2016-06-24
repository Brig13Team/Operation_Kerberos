/*
    Author: Dorbedo

    Description:
        register an artillery

    Parameter(s):
        0 : OBJECT  - Artillery to register

*/
#include "script_component.hpp"

_this params[["_newUnit",objNull,[objNull]]];

LOG_2(_this,_newUnit);
CHECK(isNull _newUnit)
If ((vehicle _newUnit) isKindOf "StaticMortar") exitWith {
    GVAR(fdc_mortars) pushBackUnique _newUnit;
};

private _mags = getArtilleryAmmo [_newUnit];
private _isRocket = ({(getText(configFile>>"CfgMagazines">> _x >> "ammo")) isKindOf "R_230mm_HE"} count _mags)>0;

//private _ammo = (getText(configFile>>"CfgMagazines">> _mags >> "ammo");
//private _isRocket = (_ammo isKindOf "R_230mm_HE");

If (_isRocket) exitWith {
    GVAR(fdc_rocket) pushBackUnique _newUnit;
};
GVAR(fdc_artilleries) pushBackUnique _newUnit;
