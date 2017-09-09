/**
 * Author: Dorbedo
 * gets the missionObjectstypes and publishes them
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

CHECK(!isServer)

private _syncHash = GHASH_CREATE;

private _objects = ["intel"] call EFUNC(mission,spawn_getObjects);
GHASH_SET(_syncHash,"intel",[_objects] param [ARR_2(0,[])]);

private _objects = ["Land_DataTerminal_01_F"];
GHASH_SET(_syncHash,"dataTerminal",[_objects] param [ARR_2(0,[])]);

private _objects = ["device"] call EFUNC(mission,spawn_getObjects);
_objects = _objects + (["emp"] call EFUNC(mission,spawn_getObjects));
GHASH_SET(_syncHash,"device",[_objects] param [ARR_2(0,[])]);

private _objects = ["upload"] call EFUNC(mission,spawn_getObjects);
GHASH_SET(_syncHash,"upload",[_objects] param [ARR_2(0,[])]);

private _objects = ["wreck"] call EFUNC(mission,spawn_getObjects);
GHASH_SET(_syncHash,"wreck",[_objects] param [ARR_2(0,[])]);

GVAR(objects) = _syncHash;
publicVariable QGVAR(objects);
