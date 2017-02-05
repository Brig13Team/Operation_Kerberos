/*
    Author: iJesuz, Dorbedo

    Description:
        internal function (to be called by taskmanager)

    Parameter(s):
        0 : HASH    - mission hash

    Return:
        -
*/
#include "script_component.hpp"

_this params ["_hash"];

private _name     = HASH_GET(_hash, "type");
private _location = [_name] call FUNC(mainmission___chooseLocation);

// set army
private _armys = getArray (missionConfigFile >> "mission_config" >> "main" >> _name >> "armys");
private _army = [_armys,1] call EFUNC(common,sel_array_weighted);
// private _army = [_armys select 0, _armys select 1] call BIS_fnc_selectRandomWeighted;
[_army select 0] call EFUNC(spawn,army_set);

// TODO:
//     call mission specific function here !!

// spawn army and defence stuff
// [_location select 1] call EFUNC(spawn,createMission);

// save variables in _hash
// HASH_SET(_hash, "location", _location);
// HASH_SET(_hash, "args", _args);
// HASH_SET(_hash, "condition", _condition);
