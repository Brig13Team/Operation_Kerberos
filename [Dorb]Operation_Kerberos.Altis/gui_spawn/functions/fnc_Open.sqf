/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

_this params ["_caller","_spawnID"];

TRACEV_2(_caller,_spawnID);

private _spawnArray = HASH_GET(GVAR(spawns),_spawnID);

(_spawnArray) params ["_vehicleList","_spawnposition","_spawnDir"];

If (IS_STRING(_vehicleList)) then {
    _vehicleList = [_vehicleList] call FUNC(getPreset);
    private _value = [_vehicleList,_spawnposition,_spawnDir];
    HASH_SET(GVAR(spawns),_spawnID,_value);
};

GVAR(curVehList) =+ _vehicleList;
GVAR(curPos) =+ _spawnposition;
GVAR(curDir) =+ _spawnDir;

disableSerialization;
createDialog QAPP(dialog);
