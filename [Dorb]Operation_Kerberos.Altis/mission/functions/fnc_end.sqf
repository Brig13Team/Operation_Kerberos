/*
 *  Author: iJesuz
 *
 *  Description:
 *      server event on mission end
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];
private _name = HASH_GET(_mission, "name");
private _type = HASH_GET(_mission, "type");

switch (_type) do {
    case "scarab": {
        private _state = HASH_GET(_mission, "state");
        if ((toUpper _state) isEqualTo "FAILED") exitWith { -1 };

        private _pos = HASH_GET(_mission, "location") select 0;
        [_pos] call FUNC(obj_spawnNuke);
    };
    // case "rtb": {
    //     [_name] call FUNC(taskmanager_remove);
    // };
};

// if (!(_type isEqualTo "_rtb") && {!(call FUNC(taskmanager_hasActiveMissions))}) then {
//    TRACEV_1(_name);
//    ["_rtb"] call FUNC(spawn);
// };
