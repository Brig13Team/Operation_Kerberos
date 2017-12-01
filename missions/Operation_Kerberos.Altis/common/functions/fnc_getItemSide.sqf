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

#define DLC_EAST ["RHS_AFRF"]
#define DLC_WEST ["RHS_USAF","BWA3","UK3CB_BAF_EQUIPMENT","UK3CB_BAF_VEHICLES","UK3CB_BAF_WEAPONS"]
#define DLC_GUER ["RHS_GREF"]
#define MODEL_EAST ["OPFOR"]
#define MODEL_WEST ["BLUFOR"]
#define MODEL_GUER ["INDEP"]
#define CLASS_EAST ["_O_","_OG_"]
#define CLASS_WEST ["_B_","_BG_","BWA3_"]
#define CLASS_GUER ["_I_","_IG_"]



params [["_className", "", [objNull, ""]]];

If (IS_OBJECT(_className)) then {
    _className = typeOf _className;
};

// possible sides [east, west, independent, civilian, sideUnknown, sideEnemy, sideFriendly, sideLogic, sideEmpty, sideAmbientLife]

private _return = [0, 1, 2, 3/*, 6, 7, 8*/];

If (isClass (configFile >> "CfgVehicles" >> _className)) exitWith {

    If !([_className, "vehicleClass", ""] call FUNC(getCfgVehicles) == 'backpacks') then {
        private _side = [_className, "side", 4] call FUNC(getCfgVehicles);
        If (_side isEqualTo 4) then {
            _return
        } else {
            [_side]
        };
    } else {
        private _tfar = [_className, "tf_encryptionCode", ""] call FUNC(getCfgVehicles);
        switch (_tfar) do {
            case "tf_east_radio_code": {[0]};
            case "tf_west_radio_code": {[1]};
            case "tf_guer_radio_code": {[2]};
            default {
                private _dlc = [_className, "dlc", ""] call FUNC(getCfgVehicles);
                If (_dlc in DLC_EAST) exitWith {[0]};
                If (_dlc in DLC_WEST) exitWith {[1]};
                If (_dlc in DLC_GUER) exitWith {[2]};

                private _side = [_className, "side", 3] call FUNC(getCfgVehicles);
                If (_side isEqualTo 3) then {
                    _return
                } else {
                    [_side]
                };
            };
        };
    };
};


If (isClass (configFile >> "CfgWeapons" >> _className)) exitWith {

    // TFAR
    private _tfar = [_className, "tf_encryptionCode", ""] call FUNC(getCfgWeapons);
    private _side = switch (_tfar) do {
        case "tf_east_radio_code": {0};
        case "tf_west_radio_code": {1};
        case "tf_guer_radio_code": {2};
        default {-1}
    };
    if (_side >= 0) exitWith {
        [_side]
    };

    // uniform
    If (isText (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "uniformClass" )) exitWith {
        private _side = [getText (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "uniformClass" ), "side", 4] call FUNC(getCfgVehicles);
        If !(_side isEqualTo 4) then {
            [_side]
        } else {
            _return
        };
    };

    // headgear
    /* RHS fucked up
    If (isArray (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "modelSides" )) exitWith {
        getArray (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "modelSides")
    };
    */

    If (isNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "side" )) exitWith {
        [getNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "side" )]
    };

    private _namestring = [[_className, "model", ""] call FUNC(getCfgWeapons),"\"] call CBA_fnc_split;
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_EAST)>0) exitWith {[0]};
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_WEST)>0) exitWith {[1]};
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_GUER)>0) exitWith {[2]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_EAST;
    If (_nameCount > 0) exitWith {[0]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_WEST;
    If (_nameCount > 0) exitWith {[1]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_GUER;
    If (_nameCount > 0) exitWith {[2]};

    private _dlc = [_className, "dlc", ""] call FUNC(getCfgWeapons);

    If (_dlc in DLC_EAST) exitWith {[0]};
    If (_dlc in DLC_WEST) exitWith {[1]};
    If (_dlc in DLC_GUER) exitWith {[2]};

    _return
};

If (isClass (configFile >> "CfgGlasses" >> _className)) exitWith {

    private _namestring = [getText(configFile >> "CfgGlasses" >> _className >> "model"), "\"] call CBA_fnc_split;
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_EAST)>0) exitWith {[0]};
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_WEST)>0) exitWith {[1]};
    If (({_x in (_namestring apply {toUpper _x})} count MODEL_GUER)>0) exitWith {[2]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_EAST;
    If (_nameCount > 0) exitWith {[0]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_WEST;
    If (_nameCount > 0) exitWith {[1]};

    private _namecount = {1 < (count ([_className, _x] call CBA_fnc_split))} count CLASS_GUER;
    If (_nameCount > 0) exitWith {[2]};

    private _dlc = getText(configFile >> "CfgGlasses" >> _className >> "dlc");

    If (_dlc in DLC_EAST) exitWith {[0]};
    If (_dlc in DLC_WEST) exitWith {[1]};
    If (_dlc in DLC_GUER) exitWith {[2]};

    _return
};


_return
