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

{
    private _curCfg = _x;
    If (getText(_x >> "dataType") == "Object") then {
        private _type = getText(_x >> "type");
        private _side = getText(_x >> "side");
        (getArray(_x >> "PositionInfo" >> "position")) params [
            ["_posX",0,[0]],
            ["_posZ",0,[0]],
            ["_posy",0,[0]]
        ];
        (getArray(_x >> "PositionInfo" >> "angles")) params [
            ["_roll",0,[0]],
            ["_yaw",0,[0]],
            ["_pitch",0,[0]]
        ];

        private _createAsSimpleObject = 0 < (getNumber(_x >> "Attributes" >> "createAsSimpleObject"));
        private _objectInit = getText(_x >> "Attributes" >> "init");


        // get the relative spawnposition
        private _relPos = ([[_posX, _posY, _posZ],_dir] call BIS_fnc_rotateVector2D) vectorAdd _centerPosition;
        // terrain surface
        private _checkPos1 = _relPos vectorAdd [0,0,30];
        private _checkPos2 = _relPos vectorAdd [0,0,-30];
        private _spawnPos = terrainIntersectAtASL[_checkPos1,_checkPos2];
        private _surfaceNormal = surfaceNormal _spawnPos;
        // add the height
        private _height = _posZ - 0.42; // remove the VR height
        // if the height value is high, it has to take
        if (abs _height > 0.3) then {
            private _heightVec = _surfaceNormal vectorMultiply _height;
            _spawnPos = _spawnPos vectorAdd _heightVec;
            _spawnPos set [2, (_spawnPos select 2) + _posZ];
        };
        private _object = if (_createAsSimpleObject) then {
            createSimpleObject [_type, [0,0,0]];
        } else {
            If (_curType isKindOf "CAManBase") then {
                
                // createUnit
            } else {
                createVehicle ["_type", [0,0,0], [], "", "NONE"]
            };
        };


        _object setDir _yaw;
        _object setPosASL _spawnPos;
        [_object, deg _pitch, deg _roll] call BIS_fnc_setPitchBank;

        _spawnedObjects pushBack _object;
    };
} count (configProperties [_compositionCfg, "isClass(_x)", true]);

_spawnedObjects
