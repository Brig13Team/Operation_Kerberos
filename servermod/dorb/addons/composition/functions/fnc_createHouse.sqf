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

params [["_house",objNull,[objNull]], ["_compositionCfg",configNull,[configNull]]];

If ((isNull _house)||{isNull _compositionCfg}) exitWith {
    ERROR(FORMAT_1("Wrong iput this=%1",_this));
};
GVAR(usedHouses) pushBack _house;

private _houseType = typeOf _house;
private _dir = getDir _house;
private _centerPosition = getPosASL _house;

private _spawnedObjects = [];
private _tempHash = HASH_CREATE;
TRACEV_2(_house, _compositionCfg);

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
        private _atlOffset = getNumber(_x >> "atlOffset");
        _offset = [
            ((getPosWorld _house) select 0)-((getPosASL _house) select 0)-(_posX),
            ((getPosWorld _house) select 1)-((getPosASL _house) select 1)-(_posY),
            ((getPosWorld _house) select 2)-((getPosASL _house) select 2)-(_posZ)-_atlOffset
        ];
        _offset = [_offset,- deg _yaw - _dir] call BIS_fnc_rotateVector2D;
    };
    nil
} count ([_compositionCfg >>"composition" >> "items", "Object"] call FUNC(getCfgDataType));

_centerPosition = _centerPosition vectorAdd _offset;

{
    private _curCfg = _x;
    If !(getText(_curCfg >> "type") isKindOf _houseType) then {
        private _curObj = [_centerPosition, _dir, _curCfg, true] call FUNC(createObjectFromCfg);
        //TRACEV_2(_curObj,_curCfg);
        If !(isNull _curObj) then {
            private _id = str (getNumber(_curCfg >> "id"));
            HASH_SET(_tempHash, _id, _curObj);
            _spawnedObjects pushBack _curObj;
        };
    };
    nil
} count ([_compositionCfg >>"composition" >> "items", "Object"] call FUNC(getCfgDataType));

{
    private _curCfg = _x;
    private _units = [_centerPosition, _dir, _curCfg, _tempHash] call FUNC(createGroupFromCfg);
    _spawnedObjects append _units;
    nil
} count ([_compositionCfg >>"composition" >> "items", "Group"] call FUNC(getCfgDataType));

{
    If (_x getVariable [QGVAR(simulationEnabled),false]) then {
        _x enableSimulationGlobal true;
    };
    nil
} count _spawnedObjects;

HASH_DELETE(_tempHash);

If (IS_ARRAY(EGVAR(mission,CompositionDesigners))) then {
    private _designer = getText(_compositionCfg >> "header" >> "author");
    EGVAR(mission,CompositionDesigners) pushBack _designer;
};

_spawnedObjects
