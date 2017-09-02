/**
 * Author: Dorbedo
 * creates given componsition at given position
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <CONFIG> the config of the composition
 * 2: <SCALAR> the direction
 *
 * Return Value:
 * <ARRAY> the spawned objects
 *
 */

#include "script_component.hpp"

params ["_centerPosition", "_dir", "_compositionCfg"];

private _spawnedObjects = [];
private _tempHash = HASH_CREATE;

{
    private _curCfg = _x;
    private _curObj = [_centerPosition, _dir, _curCfg] call FUNC(createObjectFromCfg);
    If !(isNull _curObj) then {
        private _id = getText(_curCfg >> "id");
        HASH_SET(_tempHash, _id, _curObj);
        _spawnedObjects pushBack _curObj;
    };
} count (configProperties [_compositionCfg, "((isClass _x)&&{getText(_x >> 'dataType') == 'Object'})", true]);

{
    private _curCfg = _x;
    [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
} count (configProperties [_compositionCfg, "((isClass _x)&&{getText(_x >> 'dataType') == 'Group'})", true]);


HASH_DELETE(_tempHash);

_spawnedObjects
