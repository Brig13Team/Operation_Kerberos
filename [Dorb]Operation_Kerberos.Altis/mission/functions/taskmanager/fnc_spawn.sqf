/*
    Author: iJesuz

    Description:
        create new mission

    Parameter(s):
        0 : STRING  - config name

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_name", "", [""]]];
if (_mission isEqualTo "") exitWith { -1 };

// spawn mission
GVAR(spawn_tmp) = HASH_CREATE;
HASH_SET(GVAR(spawn_tmp), "type", _name);
[GVAR(spawn_tmp)] call FUNC(mainmission___spawn);

// register mission
[GVAR(spawn_tmp)] call FUNC(taskmanager_add);
GVAR(spawn_tmp) = nil;
