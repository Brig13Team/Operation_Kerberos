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

params [
    ["_unit", objNull, [objNull]],
    "_addNVG",
    "_addFlashLight",
    "_addPointer"
];

if ((isNull _unit) || {isPlayer _unit}) exitWith {};

If (isNil "_addNVG") then {
    If (GVAR(levelNVG) isEqualTo 1) then {
        if ((!([_unit] call FUNC(hasNVG))) && {[_unit] call FUNC(hasSilencer)}) then {
            _addNVG = true;
        } else {
            _addNVG = false;
        };
    } else {
        _addNVG = GVAR(levelNVG) isEqualTo 2;
    };
};


If ((isNil "_addFlashlight") && {!(GVAR(levelAcc) isEqualTo 1)}) then {
    If (GVAR(levelAcc) isEqualTo 0) then {
        _addFlashlight = false;
        _addPointer = false;
    } else {
        If (GVAR(levelAcc) isEqualTo 2) then {
            _addPointer = false;
            _addFlashlight = true;
        } else {
            _addPointer = true;
            _addFlashlight = false;
        };
    };
};

If ((isNil "_addFlashlight") && {GVAR(levelAcc) isEqualTo 1}) then {
    if (([_unit] call FUNC(hasFlashlight)) || {[_unit] call FUNC(hasPointer)}) exitWith {
        _addPointer = false;
        _addFlashlight = false;
    };

    If ((_addNVG) || {[_unit] call FUNC(hasNVG)}) then {
        _addPointer = true;
        _addFlashlight = false;
    } else {
        _addPointer = false;
        _addFlashlight = true;
    };
};

If (_addNVG) then {
    [_unit] call FUNC(addNVG);
};

If (_addPointer || _addFlashlight) then {
    private _primary = PrimaryWeapon _unit;
    private _item = If (_addPointer) then {
        [_primary] call FUNC(getPrimaryPointer);
    } else {
        [_primary] call FUNC(getPrimaryFlashlight);
    };
    _unit addPrimaryWeaponItem _item;
};

[_addNVG, _addFlashlight, _addPointer]
