/**
 * Author: Dorbedo
 * returns if this items is a NVG
 *
 * Arguments:
 * 0: <STRING> Classname
 *
 * Return Value:
 * <BOOL> the item is a NVG
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_className", "", [""]]];

private _value = GVAR(cache) getVariable ("NVG" + _classname);

If (!isNil "_value") exitWith {_value};

_value = "NVG" in (getArray(configFile >> "CfgWeapons" >> _className >> "visionMode"));

GVAR(cache) setVariable [("NVG" + _classname), _value];
_value

