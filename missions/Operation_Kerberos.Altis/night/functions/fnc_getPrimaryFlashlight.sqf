/**
 * Author: Dorbedo
 * returns a possible Flashlight for a weapon
 *
 * Arguments:
 * 0: <STRING> weaponclass
 *
 * Return Value:
 * <STRING> possible Flashlight
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_className", "", [""]]];

private _value = GVAR(cache) getVariable ("primaryflashlight" + _classname);

If (!isNil "_value") exitWith {_value};

private _value = "";

{
    private _class = configName _x;
    If ([_class] call FUNC(isFlashlight)) exitWith {
        _value = _class;
    };
    nil
} count (configProperties[(configfile >> "CfgWeapons" >> _className >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems"), "((getNumber _x) > 0)", true]);

GVAR(cache) setVariable [("primaryflashlight" + _classname), _value];
_value
