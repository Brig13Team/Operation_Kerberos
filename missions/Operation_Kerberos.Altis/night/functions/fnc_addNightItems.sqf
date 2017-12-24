/**
 * Author: Dorbedo
 * adds the night items for units
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if ((isNull _unit) || {isPlayer _unit}) exitWith {};

private _primary = primaryWeapon _unit;
If (_primary isEqualTo "") exitWith {
    [_unit] call FUNC(addNVG);
};

If ([_unit] call FUNC(hasNVG)) then {
    If !([_unit] call FUNC(hasPointer)) then {
        private _pointer = [_primary] call FUNC(getPrimaryPointer);
        _unit addPrimaryWeaponItem _pointer;
    };
} else {
    If !([_unit] call FUNC(hasFlashlight)) then {
        private _Flashlight = [_primary] call FUNC(getPrimaryFlashlight);
        _unit addPrimaryWeaponItem _flashlight;
    };
};
