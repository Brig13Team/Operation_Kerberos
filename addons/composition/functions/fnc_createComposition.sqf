#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_createComposition
  Author: Dorbedo
  creates given composition at given position

  Arguments:
    0: position of the center <ARRAY>
    1: the config of the composition <CONFIG>
    2: direction <SCALAR>

  Return Value:
    the spawned objects <ARRAY>

  Public: No
*/

params ["_centerPosition", "_compositionCfg", ["_dir", random 360, [0]]];

GVAR(spawnedCompositions) pushBack _centerPosition;

_centerPosition set [2,CENTERPOS_OFFSET];

private _spawnedObjects = [];
private _tempHash = HASH_CREATE;

/*
 * The Objects need to be spawned first, to make it possible to move some units inside of vehicles
 */

{
    private _curCfg = _x;
    private _curObj = [_centerPosition, _dir, _curCfg] call FUNC(createObjectFromCfg);
    If !(isNull _curObj) then {
        private _id = str (getNumber(_curCfg >> "id"));
        HASH_SET(_tempHash, _id, _curObj);
        _spawnedObjects pushBack _curObj;
    };
    nil
} count ([_compositionCfg >>"composition" >> "items", "Object"] call FUNC(getCfgDataType));

{
    private _curCfg = _x;
    private _units = [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
    _spawnedObjects append _units;
    nil
} count ([_compositionCfg >>"composition" >> "items", "Group"] call FUNC(getCfgDataType));


/*
 * Move on ground
 */

[_spawnedObjects] call FUNC(alignWithSurface);

{
    If (_x getVariable [QGVAR(simulationEnabled),false]) then {
        _x enableSimulationGlobal true;
    };
    EGVAR(spawn,cleanUpDump) pushBack _x;
    If ([_x] call EFUNC(common,hasInventory)) then {
        [_x] call EFUNC(common,clearCargo);
    };
    nil
} count _spawnedObjects;

If (IS_ARRAY(EGVAR(mission,CompositionDesigners))) then {
    private _designer = getText(_compositionCfg >> "header" >> "author");
    EGVAR(mission,CompositionDesigners) pushBack _designer;
};

HASH_DELETE(_tempHash);

_spawnedObjects
