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
    case "_rtb": {
        [_name] call FUNC(taskmanager_remove);
    };
};

if (!(_type isEqualTo "_rtb") && {!(call FUNC(taskmanager_hasActiveMissions))}) then {
   ["_rtb"] call FUNC(spawn);
};
