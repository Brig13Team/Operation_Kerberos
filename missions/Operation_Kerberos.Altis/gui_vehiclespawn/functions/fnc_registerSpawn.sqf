/**
 * Author: Dorbedo
 * registers a new vehicle spawn
 *
 * Arguments:
 * 0: <ARRAY/STRING> a array with vehicles or a preset-name
 * 1: <ARRAY/OBJECT> the spawnposition where to register the spawn
 * 2: <SCALAR> the direction - Default: dir of Object or 0
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */

#include "script_component.hpp"

params [
    ["_vehicleList",[],["",[]]],
    ["_spawnPosition",[],[[],objNull],[3]],
    ["_spawnDir",nil,[0]]
];

If (isNil "_spawnDir") then {
    if (IS_OBJECT(_spawnPosition)) then {
        _spawnDir = getDir _spawnPosition;
    } else {
        _spawnDir = 0;
    };
};

if (IS_OBJECT(_spawnPosition)) then {
    _spawnPosition = getPosASL _spawnPosition;
};

private _id = str GVAR(spawnID);
INC(GVAR(spawnID));
GVAR(spawns) setVariable [_id,[_vehicleList,_spawnPosition,_spawnDir]];
_id
