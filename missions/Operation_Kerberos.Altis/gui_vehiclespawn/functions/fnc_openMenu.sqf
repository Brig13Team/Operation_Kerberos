/**
 * Author: Dorbedo
 * opens the spawn menu
 *
 * Arguments:
 * 0: <OBJECT> the target (ACE)
 * 1: <OBJECT> the caller (ACE)
 * 2: <STRING> spawn ID
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target","_caller","_spawnID"];

private _spawnArray = GVAR(spawns) getVariable _spawnID;

_spawnArray params ["_vehicleList","_spawnPosition","_spawnDir"];

If (IS_STRING(_vehicleList)) then {
    GVAR(curVehList) =+ ([_vehicleList] call FUNC(getVehicleList));
} else {
    GVAR(curVehList) =+ _vehicleList;
};

GVAR(curPos) =+ _spawnPosition;
GVAR(curDir) =+ _spawnDir;
GVAR(curVeh) = "";

disableSerialization;
createDialog QAPP(dialog);
