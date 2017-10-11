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
            "((isClass _x)&&{getNumber(_x>>'scope')>1})",
            true
        ] + configProperties [
            configfile>>"CfgGlasses",
            "((isClass _x)&&{getNumber(_x>>'scope')>1})",
            true
        ] + configProperties [
            configfile>>"CfgVehicles",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Backpacks'})",
            true
        ];

    };
};

HASH_SET(GVAR(preset),_presetName,_return);

_return;
