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

[_vehicleClass, "init", {
    params ["_vehicle"];
    _vehicle setVariable ["ACE_cargo_space",-999999];
},true,[],true] call CBA_fnc_addClassEventHandler;
