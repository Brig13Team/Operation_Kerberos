/**
 * Author: Dorbedo
 * gets the missionObjectstypes initializes them
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

If !(canSuspend) exitWith {
    _this spawn FUNC(initializeObjectsClient);
};

waitUntil {!isNil QGVAR(objects)};

[
    HASH_GET(GVAR(objects),"intel")
] call FUNC(initACEAction_intel);

[
    HASH_GET(GVAR(objects),"device")
] call FUNC(initACEAction_device);

[
    HASH_GET(GVAR(objects),"upload")
] call FUNC(initACEAction_upload);

/*
[
    HASH_GET(GVAR(objects),"wreck")
] call FUNC(initACEAction_wreck);
*/

[
    HASH_GET(GVAR(objects),"dataTerminal")
] call FUNC(initACEAction_DataTerminal);
