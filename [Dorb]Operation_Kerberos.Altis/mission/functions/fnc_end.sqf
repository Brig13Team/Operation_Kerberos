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
        [_name] spawn {
            [_this select 0] call FUNC(taskmanager_remove);

            uiSleep 5;
            while { EGVAR(spawn,cleaningUp) } do { uiSleep 1; };

            [[] call FUNC(spawn_chooseMission)] call FUNC(spawn);
        };
    };
    case "prototype": {
        private _class = HASH_GET(_mission, "prototype");
        createVehicle [_class, getMarkerPos "rescue_marker", [], 0, "NONE"];
    };
    case "wreck": {
        if (_type isEqualTo "Succeeded") then {
            private _array = _name splitString "_";
            private _parent = format["%1_%2_%3",_array select 0, _array select 1, _array select 2];
            [_parent] call FUNC(obj_markTargets);
        };
    };
};

if (!(_type isEqualTo "rtb") && {!(call FUNC(taskmanager_hasActiveMissions))}) then {
    ["rtb"] spawn FUNC(spawn);
};
