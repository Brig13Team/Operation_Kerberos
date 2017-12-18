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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerPosition","_dir","_curCfg","_objectsHash"];

//TRACEV_1(_curCfg);

If !(getText(_curCfg >> "dataType") == "Group") exitWith {};

private _LinkHash = HASH_CREATE;
private _spawnedUnits = [];
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
        private _linkCfg = HASH_GET(_LinkHash,str _id);
        private _targetVeh = HASH_GET(_objectsHash,str(getNumber(_linkCfg >> "item1")));
        private _role = getNumber(_linkCfg >> "CustomData" >> "role");

        If ((typeOf _targetVeh) in ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F"]) then {
            createVehicleCrew _targetVeh;
            (crew _targetVeh) joinSilent _group;
            _unit = (crew _targetVeh) param [0,objNull];
            _role = -1;
        } else {
            _unit = _group createUnit [_type,[0,0,10000],[],0,"NONE"];
            _unit enableSimulationGlobal false;
        };
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
        private _spawnPos = ([[_posX, _posY, _posZ],-_dir] call BIS_fnc_rotateVector2D) vectorAdd _centerPosition;
        private _atlOffset = getNumber(_x >> "atlOffset");
        _spawnPos = _spawnPos vectorAdd [0, 0, _atlOffset];

        _unit = _group createUnit [_type,[0,0,10000],[],0,"NONE"];
        _unit enableSimulationGlobal false;

        _unit setDir (_dir + (deg _yaw));
        _unit setPosWorld _spawnPos;
    };

    If (isText(_x >> "Attributes" >> "rank")) then {
        _unit setUnitRank (getText(_x >> "Attributes" >> "rank"));
    };

    If (isNumber(_x >> "Attributes" >> "skill")) then {
        _unit setSkill (getNumber(_x >> "Attributes" >> "skill"));
    };

    If (isText(_x >> "Attributes" >> "stance")) then {
        _unit setUnitPos (getText(_x >> "Attributes" >> "stance"));
    };

    _spawnedUnits pushBack ([_unit] param [0,objNull,[objNull]]);

    _unit disableAI "PATH";
    _unit addEventHandler ["FiredNear",LINKFUNC(onFiredNear)];

    _unit setVariable [QGVAR(simulationEnabled), true];
    //_unit enableSimulationGlobal true;
} forEach (configProperties[_curCfg >> "Entities","(isClass _x)",true]);

If (!(isNil QEFUNC(headquarter,registergroup))) then {
    [_group,"static"] call EFUNC(headquarter,registergroup);
};

HASH_DELETE(_LinkHash);

_spawnedUnits
