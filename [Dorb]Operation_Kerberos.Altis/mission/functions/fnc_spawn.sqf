/*
 *  Author: iJesuz
 *
 *  Description:
 *      spawn a new mission
 *
 *  Parameter(s):
 *      0 : STRING  - config name
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_name", "", [""]]];
if !(isClass(missionConfigFile >> "mission" >> "main" >> _name)) exitWith { -1 };

// spawn mission
_name spawn {
    GVAR(spawn_tmp) = HASH_CREATE;
    HASH_SET(GVAR(spawn_tmp), "type", _this);
    [GVAR(spawn_tmp)] call FUNC(mainmission___spawn);

    // register mission
    [GVAR(spawn_tmp)] call FUNC(taskmanager_add);
    GVAR(spawn_tmp) = nil;
};
