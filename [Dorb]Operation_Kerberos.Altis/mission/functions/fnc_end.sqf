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
    case "rtb": {
        [_name] call FUNC(taskmanager_remove);
    };
    case "prototype": {
        private _class = HASH_GET(_mission, "prototype");
        createVehicle [_class, getMarkerPos "rescue_marker", [], 0, "NONE"];
    };
};

if (!(_type isEqualTo "rtb") && {!(call FUNC(taskmanager_hasActiveMissions))}) then {
    ["rtb"] spawn FUNC(spawn);
};
