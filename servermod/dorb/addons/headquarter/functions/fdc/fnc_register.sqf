/*
    Author: Dorbedo

    Description:
        register an artillery

    Parameter(s):
        0 : OBJECT  - Artillery to register

*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params[["_newUnit",objNull,[objNull]]];

CHECK(isNull _newUnit)
If ((vehicle _newUnit) isKindOf "StaticMortar") exitWith {
    TRACE(FORMAT_1("New Mortar: %1",_newUnit));
    GVAR(FDC_mortars) pushBack _newUnit;
};

//private _mags = getArtilleryAmmo [_newUnit];
//private _isRocket = ({(getText(configFile>>"CfgMagazines">> _x >> "ammo")) isKindOf "R_230mm_HE"} count _mags)>0;

private _type = "";
private _weapons = weapons _newUnit;
{
    private _curWeapon = _x;
    ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
    If ((_itemtype in ["RocketLauncher"])||{_curWeapon in ["rhs_weap_grad"]}) exitWith {
        _type = "rocket";
    };
    If (_itemtype in ["Mortar"]) exitWith {
        _type = "artillery";
    };
} forEach _weapons;

switch (_type) do {
    case "artillery" : {
        TRACE(FORMAT_1("New Artillery: %1",_newUnit));
        GVAR(FDC_artilleries) pushBack _newUnit;
    };
    case "rocket" : {
        TRACE(FORMAT_1("New Rocket: %1",_newUnit));
        GVAR(FDC_rockets) pushBack _newUnit;
    };
    default {
        TRACE(FORMAT_2("New Default Rocket: %1 - %2",_newUnit,typeOf _newUnit));
        GVAR(FDC_rockets) pushBack _newUnit;
    };
};
