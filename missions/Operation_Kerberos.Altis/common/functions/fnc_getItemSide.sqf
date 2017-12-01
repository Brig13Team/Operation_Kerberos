/**
 * Author: Dorbedo
 * returns the side of an item or Unit
 *
 * Arguments:
 * 0: <STRING/OBJECT> the object or the classname
 *
 * Return Value:
 * <ARRAY> the allowed sides
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_className", "", [objNull, ""]]];

If (IS_OBJECT(_className)) then {
    _className = typeOf _className;
};

// possible sides [east, west, independent, civilian, sideUnknown, sideEnemy, sideFriendly, sideLogic, sideEmpty, sideAmbientLife]

private _return = [0, 1, 2, 3, 6, 7, 8];

If (isClass (configFile >> "CfgVehicles" >> _className)) exitWith {

    If !([_className, "vehicleClass", -1] call FUNC(getCfgVehicles) == 'backpacks') then {
        private _side = [_className, "side", 4] call FUNC(getCfgVehicles);
        If (_side isEqualTo 4) then {_return} else {[_side]};
    } else {
        private _tfar = [_className, "tf_encryptionCode", ""] call FUNC(getCfgVehicles);
        switch (_tfar) do {
            case "tf_east_radio_code": {0};
            case "tf_west_radio_code": {1};
            case "tf_guer_radio_code": {2};
            default {
                private _side = [_className, "side", 4] call FUNC(getCfgVehicles);
                If (_side isEqualTo 4) then {_return} else {[_side]};
            };
        };
    };
};


If (isClass (configFile >> "CfgWeapons" >> _className)) exitWith {

    // TFAR
    private _tfar = [_className, "tf_encryptionCode", ""] call FUNC(getCfgVehicles);
    private _side = switch (_tfar) do {
        case "tf_east_radio_code": {0};
        case "tf_west_radio_code": {1};
        case "tf_guer_radio_code": {2};
        default {-1}
    };
    if (_side >= 0) exitWith {[_side]};

    // uniform
    If (isText (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "uniformClass" )) exitWith {
        private _side = [getText (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "uniformClass" ), "side", 4] call FUNC(getCfgVehicles);
        If (_side isEqualTo 4) then {_return} else {[_side]};
    };

    // headgear
    If (isArray (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "modelSides" )) exitWith {
        getArray (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "modelSides");
    };

    If (isNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "side" )) exitWith {
        [getNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "side" )];
    };

};

_return
