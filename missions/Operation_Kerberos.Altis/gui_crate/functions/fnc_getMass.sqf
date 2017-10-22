/**
 * Author: Dorbedo
 * return the mass of an item(s)
 *
 * Arguments:
 * 0: <STRING/CONFIG> the item
 * 1: <SCALAR> the amount
 *
 * Return Value:
 * <SCALAR> the mass
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_config","",["",configNull]],["_amount",1,[1]]];

If (((toLower _config) find "configfile")>=0) then {
    _config = [_config,configFile] call BIS_fnc_configPath;
} else {
    _config = [_config,configFile] call CBA_fnc_getItemConfig;
};

private _mass = getnumber (_config>>"mass");
If (_mass isEqualTo 0) then {
    _mass = getnumber (_config>>"ItemInfo">>"mass");
    If (_mass isEqualTo 0) then {
        _mass = getnumber (_config>>"WeaponSlotsInfo">>"mass");
    };
};
(_mass * _amount * MASS_CORRECTION)
