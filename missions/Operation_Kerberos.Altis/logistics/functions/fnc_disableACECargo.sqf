/**
 * Author: Dorbedo
 * disables the ace cargo if the class
 *
 * Arguments:
 * 0: <STRING> vehicleclass
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_vehicleClass","",[""]]];

If !(isClass(configFile >> "CfgVehicles" >> _vehicleClass)) exitWith {};

[_vehicleClass, "initPost", {
    params ["_vehicle"];
    if (local _vehicle) then {
        If !(isNil {_vehicle getVariable "ace_cargo_setSpace_jipID"}) then {
            _vehicle setVariable ["ace_cargo_setSpace_jipID", nil, true];
        };
        _vehicle setVariable ["ace_cargo_space", -99999, true];
    };
}, false, [], true] call CBA_fnc_addClassEventHandler;
