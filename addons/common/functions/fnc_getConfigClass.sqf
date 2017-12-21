/**
 * Author: Dorbedo
 * this function returns the configClass from missionConfigFile
 * if defined, otherwise, it returns from configfile
 * if non existent class is given in config format, configNull is returned
 *
 * Arguments:
 * <CONFIG/ARRAY> the configpath
 *
 * Return Value:
 * <CONFIG> missionconfigpath, if defined, otherwise configfile
 *
 */

#include "script_component.hpp"

// configFile >> "CfgVehicles" >> ...
If (_this isEqualType configNull) exitWith {
    private _array = (str _this) splitString "/";
    // configNull was given
    If (_array isEqualTo []) exitWith {
        TRACEV_2(_array,_this);
        configNull
    };
    _array deleteAt 0;

    // check if the value exists missionside
    private _cfg = missionConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    // check if the value exists configside
    private _cfg = ConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    configNull
};
// [configFile,"CfgVehicles", ...]
If (_this isEqualTypeParams [configNull]) exitWith {
    private _array =+ _this;
    _array deleteAt 0;

    // check if the value exists missionside
    private _cfg = missionConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    // check if the value exists configside
    private _cfg = ConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    configNull
};
// ["configFile","CfgVehicles",...] or ["CfgVehicles",...]
if (_this isEqualTypeParams [""]) exitWith {
    private _array =+ _this;
    If  (
            ((_this select 0) == "missionConfigFile")||
            {(_this select 0) == str missionConfigFile}||
            {(_this select 0) == "ConfigFile"}||
            {(_this select 0) == str ConfigFile}
        ) then {_array deleteAt 0;};

    // check if the value exists missionside
    private _cfg = missionConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    // check if the value exists configside
    private _cfg = ConfigFile;
    {_cfg = _cfg >> _x;nil} count _array;
    If (isClass _cfg) exitWith {_cfg};
    configNull
};

configNull
