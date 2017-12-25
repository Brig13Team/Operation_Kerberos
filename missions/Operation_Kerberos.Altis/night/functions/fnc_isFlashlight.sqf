/**
 * Author: Dorbedo
 * returns if this items is a flashlight
 *
 * Arguments:
 * 0: <STRING> Classname
 *
 * Return Value:
 * <BOOL> the item is a flashlight
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_className", "", [""]]];

private _value = GVAR(cache) getVariable ("flashlight" + _classname);

If (!isNil "_value") exitWith {_value};

_value = 0 < getNumber(configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "Flashlight" >> "intensity");

GVAR(cache) setVariable [("flashlight" + _classname), _value];
_value
