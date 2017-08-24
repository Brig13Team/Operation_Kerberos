/**
 * Author: Dorbedo
 * interface for vehiclelist
 *
 * Arguments:
 * 0: <STRING> vehiclelist preset
 *
 * Return Value:
 * <ARRAY> array with classnames
 *
 */

#include "script_component.hpp"

params ["_presetName"];

private _return = [];

switch (_presetName) do {
    case "vehicles_west" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
    };
    case "air_west" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
    };
    case "naval_west" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };

    case "vehicles_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        _return = _return select {!((toLower _x) in ["rhs_9k79_b"])};
    };
    case "air_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
    };
    case "naval_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };

    case "vehicles_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
    };
    case "air_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
    };
    case "naval_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };


    default {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Air')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        #ifdef DEBUG_MODE_FULL
            _return pushBack "Land_VR_Block_05_F";
        #endif
        _return = _return select {!((toLower _x) in ["rhs_9k79_b"])};
    };
};

_return = _return apply {
    [
        [configfile >> "CfgVehicles" >> _x] call EFUNC(common,getModPicture),
        [configfile >> "CfgVehicles" >> _x] call EFUNC(common,getMod),
        [configfile >> "CfgVehicles" >> _x] call FUNC(getVehicleIcon),
        getText(configFile >> "CfgVehicles" >> _x >> "displayName"),
        _x
    ]
};

_return;
