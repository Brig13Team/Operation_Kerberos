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

_return = _return apply {
    [
        configname _x,
        [_x] call EFUNC(common,getModPicture),
        [_x] call EFUNC(common,getMod),
        [_x] call FUNC(getVehicleIcon),
        getText(_x >> "displayName"),
        _x
    ]
};

_return;
