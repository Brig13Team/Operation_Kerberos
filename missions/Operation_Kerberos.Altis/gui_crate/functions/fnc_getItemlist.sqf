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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_presetName","",[""]]];

private _return = [];

If !(HASH_GET_DEF(GVAR(preset),_presetName,[]) isEqualTo []) exitWith {
    HASH_GET(GVAR(preset),_presetName);
};

switch (_presetName) do {
    case "WEST" : {
        _return = configProperties [
            configfile>>"CfgWeapons",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{!(getText(_x>>'displayName') isEqualTo '')}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==1}else{true}}&&{((configName _x) call bis_fnc_baseWeapon == (configName _x))})",
            true
        ] + configProperties [
            configfile>>"CfgGlasses",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==1}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
            true
        ] + configProperties [
            configfile>>"CfgVehicles",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Backpacks'}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==1}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
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
    case "EAST" : {
        _return = configProperties [
            configfile>>"CfgWeapons",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{!(getText(_x>>'displayName') isEqualTo '')}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==0}else{true}}&&{((configName _x) call bis_fnc_baseWeapon == (configName _x))})",
            true
        ] + configProperties [
            configfile>>"CfgGlasses",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==0}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
            true
        ] + configProperties [
            configfile>>"CfgVehicles",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Backpacks'}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==0}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
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
    case "GUER" : {
        _return = configProperties [
            configfile>>"CfgWeapons",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{!(getText(_x>>'displayName') isEqualTo '')}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==2}else{true}}&&{((configName _x) call bis_fnc_baseWeapon == (configName _x))})",
            true
        ] + configProperties [
            configfile>>"CfgGlasses",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==2}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
            true
        ] + configProperties [
            configfile>>"CfgVehicles",
            "((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Backpacks'}&&{If(isNumber(_x>>'side'))then{getNumber(_x>>'side')==2}else{true}}&&{!(getText(_x>>'displayName') isEqualTo '')})",
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
    case "GUI_ARSENAL" : {
        _return = [] call EFUNC(gui_arsenal,getCurrentList);
        _return = _return apply {
            private _ret = _x call CBA_fnc_getItemConfig;
            if (isNull _ret) then {
                _x call CBA_fnc_getObjectConfig;
            } else {
                _ret
            };
        };
        _return = _return - [configNull];
    };
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

TRACEV_2(_presetName,_return);

If (isClass(configFile >> "CfgMagazines" >> "ACE_SpareBarrel")) then {
    _return pushBackUnique (configfile >> "CfgMagazines" >> "ACE_SpareBarrel");
};

_return = _return apply {[_x,""] call BIS_fnc_configPath};

HASH_SET(GVAR(preset),_presetName,_return);

_return
