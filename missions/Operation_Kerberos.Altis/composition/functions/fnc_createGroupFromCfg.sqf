/**
 * Author: Dorbedo
 * creates a group from the composition
 *
 * Arguments:
 * 0: <ARRAY> Centerposition
 * 1: <SCALAR> Centerdir
 * 2: <CONFIG> Group Config
 * 3: <LOCATION> hash with spawned Objects
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_spawnposition","_dir","_curCfg","_objectsHash"];

If (getText(_curCfg >> "dataType") == "Group") exitWith {};

private _LinkHash = HASH_CREATE;
If (isClass(_curCfg >> "CrewLinks")) then {
    {
        private _id = getNumber(_x >> "item0");
        HASH_SET(_LinkHash,str _id,_x);
    } forEach (configProperties[_curCfg >> "CrewLinks" >> "Links","(isClass _x)",true]);
};

private _group = createGroup [GVARMAIN(side),true];
{
    private _id = getNumber(_x >> "id");
    private _type = [getText(_x >> "type")] call FUNC(getReplacement);

    private "_unit";
    If (HASH_HASKEY(_LinkHash,str _id)) then {
        _unit = _group createUnit [_type,[0,0,10000],[],0,"NONE"];
        _unit enableSimulationGlobal false;
        _linkCfg = HASH_GET(_LinkHash,str _id);
        _targetVeh = HASH_GET(_objectsHash,str(getNumber(_linkCfg >> "item1")));
        _role = getNumber(_linkCfg >> "CustomData" >> "role");
        switch _role do {
            case 1 : {_unit moveInDriver _targetVeh};
            case 2 : {
                private _turretPath = getArray(_linkCfg >> "CustomData" >> "turretPath");
                _unit moveInTurret [_targetVeh,_turretPath];
            };
            case 3 : {
                private _cargoIndex = getArray(_linkCfg >> "CustomData" >> "cargoIndex");
                _unit moveInCargo [_targetVeh,_cargoIndex];
            };
        };
    } else {

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

        // get the relative spawnposition
        private _relPos = ([[_posX, _posY, _posZ],_dir] call BIS_fnc_rotateVector2D) vectorAdd _centerPosition;
        // terrain surface
        private _checkPos1 = _relPos vectorAdd [0,0,30];
        private _checkPos2 = _relPos vectorAdd [0,0,-30];
        private _spawnPos = terrainIntersectAtASL[_checkPos1,_checkPos2];
        private _surfaceNormal = surfaceNormal _spawnPos;
        // add the height
        private _height = _posZ - 0.0014390945; // remove the VR height
        // if the height value is high, it has to take
        if (abs _height > 0.3) then {
            private _heightVec = _surfaceNormal vectorMultiply _height;
            _spawnPos = _spawnPos vectorAdd _heightVec;
            _spawnPos set [2, (_spawnPos select 2) + _posZ];
        };
        _unit = _group createUnit [_type,[0,0,10000],[],0,"NONE"];
        _unit enableSimulationGlobal false;
        _unit setDir _yaw;
        _unit setPosASL _spawnPos;
    };

    If (isText(_x >> "Attributes" >> "rank")) then {
        _unit setUnitRank (getText(_x >> "Attributes" >> "rank"));
    };
    If (isNumber(_x >> "Attributes" >> "skill")) then {
        _unit setSkill (getNumber(_x >> "Attributes" >> "skill"));
    };


    _unit enableSimulationGlobal true;
} forEach (configProperties[_curCfg >> "CrewLinks" >> "Links","(isClass _x)",true]);

HASH_DELETE(_LinkHash);
