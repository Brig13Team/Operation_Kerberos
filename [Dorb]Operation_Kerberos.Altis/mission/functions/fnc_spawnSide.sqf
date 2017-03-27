/*
 *  Author: iJesuz
 *
 *  Description:
 *      spawn a new side mission
 *
 *  Parameter(s):
 *      0 : STRING   - parent mission
 *      1 : STRING   - config name
 *      2 : [OBJECT] - (optional) targets
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_parent", "", [""]], ["_name", "", [""]]];
if !(HASH_HASKEY(GVAR(master), _parent)) exitWith { -1 };
if !(isClass(missionConfigFile >> "mission" >> "side" >> _type)) exitWith { -1 };

_this spawn {
    _this params [["_parent", "", [""]], ["_type", "", [""]], ["_targets", [], [[]]]];

    while !(isNil QGVAR(spawnSide_tmp)) do { uiSleep 5; };
    TRACE("Spawning started!");

    GVAR(spawnSide_tmp) = HASH_CREATE;
    private _hash = GVAR(spawnSide_tmp);
    HASH_SET(_hash, "type", _type);
    HASH_SET(_hash, "location", HASH_GET(HASH_GET(GVAR(master),_parent),"location")); // needed for FUNC(mainmission_spawnTargets) and HQ
    HASH_SET(_hash, "side", true); // needed for spawn- and hq-functions
    HASH_SET(_hash, "state", "init");

    // spawn targets
    if (_targets isEqualTo []) then {
       _targets = [_type, _position] call FUNC(spawn_spawnTargets);
    };
    { _x setVariable [QGVAR(mission),_hash]; } forEach _targets;

    TRACEV_1(_targets);
    [_hash, _targets] call (missionNamespace getVariable [format ["%1_%2", QFUNC(sidemission), _type], {}]);

    // register mission
    [_parent, _hash] call FUNC(taskmanager_addChild);

    GVAR(spawnSide_tmp) = nil;
};
