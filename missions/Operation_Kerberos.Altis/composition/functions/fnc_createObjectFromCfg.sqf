/**
 * Author: Dorbedo
 * creates the object from the config entry
 *
 * Arguments:
 * 0: <ARRAY> Centerposition
 * 1: <SCALAR> Centerdir
 * 2: <CONFIG> Configpath
 *
 * Return Value:
 * <OBJECT> the created Object
 *
 */

#include "script_component.hpp"

params ["_spawnposition","_dir","_curCfg"];

private _object = objNull;

If (getText(_curCfg >> "dataType") == "Object") then {
    private _type = getText(_curCfg >> "type");
    _type = [_type] call FUNC(getReplacement);

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
//    _spawnPos set [2, (getTerrainHeightASL _spawnPos) + _posZ];
//    private _surfaceNormal = surfaceNormal _spawnPos;

    private _createAsSimpleObject = [false,true] select (getNumber(_curCfg >> "Attributes" >> "createAsSimpleObject"));
    _object = if (_createAsSimpleObject) then {
        createSimpleObject [_type, [0,0,0]];
    } else {
        createVehicle [_type, [0,0,10000], [], 0, "NONE"]
    };
    _object enableSimulationGlobal false;

    _object setDir (_dir + (deg _yaw));
    _object setPosWorld _spawnPos;
    TRACEV_2(_spawnPos,_yaw);
    [_object, deg _pitch, deg _roll] call BIS_fnc_setPitchBank;

/*
    If !((_object isKindOf "HouseBase")||(_object isKindOf "LandVehicle")||(_object isKindOf "Air")) then {
        private _objVec = vectorUp _object;
        private _heightVec = _surfaceNormal vectorMultiply ((getPosATL _object)select 2);
        _objVec = (_objVec) vectorAdd _heightVec;
        _object setVectorUp (vectorNormalized _objVec);
    };
*/

    private _lock = getText(_curCfg >> "Attributes" >> "lock");
    If !(_lock isEqualTo "") then {
        _object setVehicleLock _lock;
    };
    If (isNumber(_curCfg >> "Attributes" >> "fuel")) then {
        _object setFuel (getNumber(_curCfg >> "Attributes" >> "fuel"));
    };
    If ((_type isKindOf "Air")&&{((surfaceIsWater _spawnpos) || (((_spawnpos select 2)-(_centerpos select 2))>5))}) then {
            _object engineOn true;
    };

    If (_type isKindOf "MineBase") then {
        GVARMAIN(side) revealMine _object;
    };

    If (isNumber(_curCfg >> "Attributes" >> "health")) then {
        _object setDamage (1-(getNumber(_curCfg >> "Attributes" >> "health")));
    };
    If (isNumber(_curCfg >> "Attributes" >> "ammo")) then {
        _object setVehicleAmmo (getNumber(_curCfg >> "Attributes" >> "ammo"));
    };
    private _texture = getText(_curCfg >> "Attributes" >> "textures");
    If !(_texture isEqualTo "") then {
        _object setObjectTextureGlobal [0, _texture];
    };

    private _simulationEnabled = [true,false] select (getNumber(_curCfg >> "Attributes" >> "disableSimulation"));
    _object setVariable [QGVAR(simulationEnabled), _simulationEnabled];

    private _dynamicSimulation = [false,true] select (getNumber(_curCfg >> "Attributes" >> "dynamicSimulation"));
    _object enableDynamicSimulation _dynamicSimulation;

    private _reportRemoteTargets = [false,true] select (getNumber(_curCfg >> "Attributes" >> "reportRemoteTargets"));
    If (_reportRemoteTargets) then {
        _object setVehicleReportRemoteTargets true;
    };

    private _receiveRemoteTargets = [false,true] select (getNumber(_curCfg >> "Attributes" >> "receiveRemoteTargets"));
    If (_receiveRemoteTargets) then {
        _object setVehicleReceiveRemoteTargets true;
    };
    If (isNumber(_curCfg >> "Attributes" >> "aiRadarUsage")) then {
        _object setVehicleRadar (getNumber(_curCfg >> "Attributes" >> "aiRadarUsage"));
    };


};

_object
