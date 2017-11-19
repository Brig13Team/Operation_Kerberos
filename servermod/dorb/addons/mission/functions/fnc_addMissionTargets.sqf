#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_addMissionTargets
 *
 * Author: Dorbedo
 * adds missiontargets for client specific actions
 *
 * Arguments:
 * 0: <OBJECT> object to add
 *
 * Return Value:
 * Nothing
 *
 */

params [["_objectsToAdd", [], [[], objNull]]];

If (IS_OBEJCT(_objectsToAdd)) then {
    _objectsToAdd = [_objectsToAdd];
};

GVAR(targets_client) = (GVAR(targets_client) select {!(isNull _x)}) append _objectsToAdd;
publicVariable QGVAR(targets_client);
