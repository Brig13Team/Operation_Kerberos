/*
    Author: iJesuz, Dorbedo

    Description:
        internal function
        (to be called by taskmanager)

    Parameter(s):
        0 : HASH    - mission hash

    Return:
        -
*/
#include "script_component.hpp"

_this params ["_hash"];

// export settings
private _name     = HASH_GET(_hash, "type");
private _location = [_name] call FUNC(mainmission___chooseLocation);
HASH_SET(_hash, "location", _location);
HASH_SET(_hash, "state", "init");

// set army
private _armys = getArray (missionConfigFile >> "mission_config" >> "main" >> _name >> "armys");
private _army = [_armys,1] call EFUNC(common,sel_array_weighted);
// private _army = [_armys select 0, _armys select 1] call BIS_fnc_selectRandomWeighted;
[_army select 0] call EFUNC(spawn,army_set);

// call mission specific function
private _fnc = format["%1_%2", QFUNC(mainmission), _name];
[_hash] call (missionNamespace getVariable [_fnc, {}]);

// spawn army and defence stuff
// [_location select 1] call EFUNC(spawn,createMission);
