/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

_this params ["_display","_vehicle"];

private _ctrl = _display displayCtrl IDC_ARTILLERY_PROPERTIES_AMMUNITION;

private _artyMags = getArtilleryAmmo [_vehicle];
lnbClear _ctrl;
{
    _x params ["_curAmmo","_turret","_amount"];
    if (_curAmmo in _artyMags) then {
        private _name = getText(configfile >> "CfgMagazines" >> _curAmmo >> "displayNameShort");
        _ctrl lnbAddRow [_name,format["%1",_amount]];
    };
} forEach (magazinesAllTurrets _vehicle);
