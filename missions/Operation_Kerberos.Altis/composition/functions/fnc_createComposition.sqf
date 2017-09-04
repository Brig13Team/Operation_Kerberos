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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerPosition", "_dir", "_compositionCfg"];

_centerPosition set [2,0];
_centerPosition = ATLToASL _centerPosition;

private _spawnedObjects = [];
private _tempHash = HASH_CREATE;
TRACEV_1(_compositionCfg);
{
    private _curCfg = _x;
    private _curObj = [_centerPosition, _dir, _curCfg] call FUNC(createObjectFromCfg);
    //TRACEV_2(_curObj,_curCfg);
    If !(isNull _curObj) then {
        private _id = str (getNumber(_curCfg >> "id"));
        HASH_SET(_tempHash, _id, _curObj);
        _spawnedObjects pushBack _curObj;
    };
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Object'})", true]);

{
    private _curCfg = _x;
    [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Group'})", true]);


HASH_DELETE(_tempHash);

_spawnedObjects
