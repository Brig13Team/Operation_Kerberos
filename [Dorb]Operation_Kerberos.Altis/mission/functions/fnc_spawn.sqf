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

_this params [["_type", "", [""]]];
if !(isClass(missionConfigFile >> "mission" >> "main" >> _type)) exitWith { -1 };

[_type] spawn {
    _this params ["_type"];

    while { !(isNil QGVAR(spawn_tmp)) } do { uiSleep 5; };
    TRACE("Spawning started!");

    // create mission hash
    GVAR(spawn_tmp) = HASH_CREATE;
    private _hash = GVAR(spawn_tmp);
    HASH_SET(_hash, "type", _type);
    HASH_SET(_hash, "state", "init");

    if !(_type isEqualTo "rtb") then {
        // create normal mission
        private _location = [_type] call FUNC(spawn_chooseLocation);
        private _position = _location select 1;
        HASH_SET(_hash, "location", _location);

        // spawn targets
        private _targets = [_type, _position] call FUNC(spawn_spawnTargets);
        { _x setVariable [QGVAR(mission),_hash]; } forEach _targets;

        TRACEV_1(_targets);
        [_hash, _targets] call (missionNamespace getVariable [format ["%1_%2", QFUNC(mainmission), _type], {}]);

        // spawn defence stuff
        [_position] call EFUNC(spawn,createMission);
    } else {
        // create rtb mission
        [_hash] call FUNC(mainmission_rtb);
    };

    // register mission
    [GVAR(spawn_tmp)] call FUNC(taskmanager_add);

    GVAR(spawn_tmp) = nil;
};
