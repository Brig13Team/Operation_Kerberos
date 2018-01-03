/**
 * Author: Dorbedo
 * returns if this items is a silencer
 *
 * Arguments:
 * 0: <STRING> Classname
 *
 * Return Value:
 * <BOOL> the item is a silencer
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_className", "", [""]]];

private _value = GVAR(cache) getVariable ("silencer" + _classname);

If (!isNil "_value") exitWith {_value};

_value = (isNumber(configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "AmmoCoef" >> "audibleFire")) &&
    {0.6 > (getNumber(configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "AmmoCoef" >> "audibleFire"))};

GVAR(cache) setVariable [("silencer" + _classname), _value];
_value

