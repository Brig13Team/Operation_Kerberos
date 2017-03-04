/*
 *  Author: iJesuz
 *
 *  Description:
 *      spawn a new side mission
 *
 *  Parameter(s):
 *      0 : STRING  - parent mission
 *      1 : STRING  - config name
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_parent", "", [""]], ["_name", "", [""]]];
if !(isClass(missionConfigFile >> "mission" >> "side" >> _name)) exitWith { -1 };
if !(HASH_HASKEY(GVAR(master), _parent)) exitWith { -1 };

// spawn mission
_this spawn {
    _this params [["_parent", "", [""]], ["_name", "", [""]]];

    GVAR(spawnSide_tmp) = HASH_CREATE;
    HASH_SET(GVAR(spawnSide_tmp), "type", _name);

    HASH_SET(GVAR(spawnSide_tmp), "location", HASH_GET(HASH_GET(GVAR(master),_parent),"location")); // needed for FUNC(mainmission_spawnTargets) and HQ
    HASH_SET(GVAR(spawnSide_tmp), "side", true); // needed for spawn- and hq-functions

    [GVAR(spawnSide_tmp)] call FUNC(sidemission___spawn);

    // register mission
    [_parent, GVAR(spawnSide_tmp)] call FUNC(taskmanager_addChild);
    GVAR(spawnSide_tmp) = nil;
};
