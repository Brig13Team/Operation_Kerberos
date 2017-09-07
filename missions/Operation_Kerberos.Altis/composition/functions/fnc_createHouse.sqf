/**
 * Author: Dorbedo
 * creates given componsition at given position
 *
 * Arguments:
 * 0: <OBJECT> the House
 * 1: <CONFIG> the config of the composition
 *
 * Return Value:
 * <ARRAY> the spawned objects
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_house", "_compositionCfg"];

GVAR(usedHouses) pushBack _house;

private _houseType = typeOf _house;
private _dir = getDir _house;
private _dir2 = (getPosASL _house) getDir (_house modelToWorld [0,1,0]);
TRACEV_5(_house,_compositionCfg,_dir,_dir2,_houseType);
_dir = _dir2;
private _centerPosition = getPosASL _house;


private _spawnedObjects = [];
private _tempHash = HASH_CREATE;
TRACEV_1(_compositionCfg);

/*
 * The Objects need to be spawned first, to make it possible to move some units inside of vehicles
 */

private _offset = [0,0,0];
{
    private _curCfg = _x;
    If (getText(_curCfg >> "type") isKindOf _houseType) exitWith {
        (getArray(_curCfg >> "PositionInfo" >> "position")) params [
            ["_posX",0,[0]],
            ["_posZ",0,[0]],
            ["_posy",0,[0]]
        ];
        (getArray(_x >> "PositionInfo" >> "angles")) params [
            ["_roll",0,[0]],
            ["_yaw",0,[0]],
            ["_pitch",0,[0]]
        ];
        _offset = [
            _posX,
            _posY,
            ((getPosWorld _house) select 2)-((getPosASL _house) select 2)-(_posZ)
        ];
        _offset = [_offset,-_yaw] call BIS_fnc_rotateVector2D;
    };
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Object'})", true]);

_centerPosition = _centerPosition vectorDiff _offset;

{
    private _curCfg = _x;
    If !(getText(_curCfg >> "type") isKindOf _houseType) then {
        private _curObj = [_centerPosition, _dir, _curCfg] call FUNC(createObjectFromCfg);
        //TRACEV_2(_curObj,_curCfg);
        If !(isNull _curObj) then {
            private _id = str (getNumber(_curCfg >> "id"));
            HASH_SET(_tempHash, _id, _curObj);
            _spawnedObjects pushBack _curObj;
        };
    };
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Object'})", true]);

{
    private _curCfg = _x;
    private _units = [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
    _spawnedObjects append _units;
    nil
} count (configProperties [_compositionCfg >>"composition" >> "items", "((isClass _x)&&{getText(_x >> 'dataType') == 'Group'})", true]);

{
    If (_x getVariable [QGVAR(simulationEnabled),false]) then {
        _x enableSimulationGlobal true;
    };
    nil
} count _spawnedObjects;

HASH_DELETE(_tempHash);

_spawnedObjects
