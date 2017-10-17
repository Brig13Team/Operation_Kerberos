/**
 * Author: Dorbedo
 * returns the size of a container
 *
 * Arguments:
 * 0: <STRING/OBJECT> container/the type
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_config"];

if (IS_OBJECT(_config)) then {
    _config = typeOf _config;
};
private _boxes = DEFAULT_BOXES;
TRACEV_3(_config in _boxes,_config,_boxes);
If ((toLower _config) in DEFAULT_BOXES) exitWith {
    TRACEV_1(_boxes find _config);
    DEFAULT_BOXES_MASS select (DEFAULT_BOXES find (toLower _config))
};

_config = configFile >> "CfgVehicles" >> _config;

If (getNumber(_config >> "ace_cargo_hasCargo") > 0) exitWith {
    (getNumber(_config >> "ace_cargo_space")) * DEFAULT_MASS;
};

If (getNumber(_config >> "ace_cargo_canLoad") > 0) exitWith {
    (getNumber(_config >> "ace_cargo_size")) * DEFAULT_MASS;
};

2 * DEFAULT_MASS
