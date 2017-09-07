/**
 * Author: Dorbedo
 * creates given componsition at given position
 *
 * Arguments:
 * 0: <ARRAY> the centerposition (only 2D coordiantes are used)
 * 1: <CONFIG> the config of the composition
 * 2: <SCALAR> the direction
 *
 * Return Value:
 * <ARRAY> the spawned objects
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerPosition", "_compositionCfg", "_dir"];

GVAR(spawnedCompositions) pushBack _centerpos;

_centerPosition set [2,CENTERPOS_OFFSET];


private _spawnedObjects = [];
private _tempHash = HASH_CREATE;
TRACEV_1(_compositionCfg);

/*
 * The Objects need to be spawned first, to make it possible to move some units inside of vehicles
 */

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
    private _units = [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
    _spawnedObjects append _units;
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Group'})", true]);


/*
 * Move on ground
 */

[_spawnedObjects] call FUNC(alignWithSurface);

{
    If (_x getVariable [QGVAR(simulationEnabled),false]) then {
        _x enableSimulationGlobal true;
    };
    nil
} count _spawnedObjects;

HASH_DELETE(_tempHash);

_spawnedObjects
