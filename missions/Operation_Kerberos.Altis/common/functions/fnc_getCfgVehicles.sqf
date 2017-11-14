/**
 * Author: Dorbedo
 * returns a caches value from CfgVehicles
 *
 * Arguments:
 * 0: <STRING> classname
 * 1: <STRING> valueName
 * 2: <ANY> default value
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_configname", "", [""]], ["_valueName", "", [""]], ["_default", ""]];

private _cacheEntry = (_configName+_valueName);
private _value = GVAR(cfgVehicleCacheLocal) getVariable _valueName;

If !(isNil "_value") exitWith {_value};

private _cfg = configFile >> "CfgVehicles" >> _configName >> _valueName;

If (isNumber _cfg) then {
    _value = getNumber _cfg;
    GVAR(cfgVehicleCacheLocal) setVariable [_valueName, _value];
    _value
};

If (isText _cfg) then {
    _value = getText _cfg;
    GVAR(cfgVehicleCacheLocal) setVariable [_valueName, _value];
    _value
};

If (isArray _cfg) then {
    _value = getArray _cfg;
    GVAR(cfgVehicleCacheLocal) setVariable [_valueName, _value];
    _value
};

GVAR(cfgVehicleCacheLocal) setVariable [_valueName, _default];

_value
