/**
 * Author: Dorbedo
 * interface for itemlist
 *
 * Arguments:
 * 0: <STRING> itemlist preset
 *
 * Return Value:
 * <ARRAY> array with classnames
 *
 */

#include "script_component.hpp"

params [["_presetName","",[""]]];

private _return = [];

If !(HASH_GET_DEF(GVAR(preset),_presetName,[]) isEqualTo []) exitWith {
    HASH_GET_DEF(GVAR(preset),_presetName);
};

switch (_presetName) do {

    default {
        _return = configProperties [
            configfile>>"CfgWeapons",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{!(getText(_x>>'displayName') isEqualTo '')}&&{((configName _x) call bis_fnc_baseWeapon == (configName _x))})",
            true
        ] + configProperties [
            configfile>>"CfgGlasses",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{!(getText(_x>>'displayName') isEqualTo '')})",
            true
        ] + configProperties [
            configfile>>"CfgVehicles",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Backpacks'}&&{!(getText(_x>>'displayName') isEqualTo '')})",
            true
        ];
        // throw and put
        {
            {
                if (getnumber (configfile >> "cfgmagazines" >> _x >> "scope") > 1) then {
                    _return pushBack (configfile >> "cfgmagazines" >> _x);
                };
                nil
            } count getArray(_x>>"magazines");
            nil
        } count configProperties [configfile>>"cfgweapons">>"put","isClass(_x)",true] + configProperties [configfile>>"cfgweapons">>"throw","isClass(_x)",true];
    };
};

_return = _return apply {[_x,""] call BIS_fnc_configPath};

HASH_SET(GVAR(preset),_presetName,_return);

_return
