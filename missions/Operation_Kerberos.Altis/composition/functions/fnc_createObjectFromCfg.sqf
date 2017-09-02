/**
 * Author: Dorbedo
 * creates the object from the config entry
 *
 * Arguments:
 * 0: <CONFIG> the configpath of the Object
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

    private _createAsSimpleObject = [false,true] select (getNumber(_curCfg >> "Attributes" >> "createAsSimpleObject"));
    private _object = if (_createAsSimpleObject) then {
        createSimpleObject [_type, [0,0,0]];
    } else {
        createVehicle ["_type", [0,0,10000], [], "", "NONE"]
    };
    _object enableSimulationGlobal false;

    _object setDir _yaw;
    _object setPosASL _spawnPos;
    [_object, deg _pitch, deg _roll] call BIS_fnc_setPitchBank;

    private _lock = getText(_curCfg >> "Attributes" >> "lock");
    If !(_lock isEqualTo "") then {
        _object setVehicleLock _lock;
    };
    If (isNumber(_curCfg >> "Attributes" >> "fuel")) then {
        _object setFuel (getNumber(_curCfg >> "Attributes" >> "fuel"));
    };
    If ((_type isKindOf "Air")&&{
        ((surfaceIsWater _spawnpos) && ((_spawnpos select 2)>5))||
        {(ATLToASL [_spawnpos select 0, _spawnpos select 1, 0] distance _spawnpos)>18}
        }) then {
            _object engineOn true;
    };
    If (isNumber(_curCfg >> "Attributes" >> "health")) then {
        _object setDamage (1-(getNumber(_curCfg >> "Attributes" >> "health")));
    };
    If (isNumber(_curCfg >> "Attributes" >> "ammo")) then {
        _object setVehicleAmmo (getNumber(_curCfg >> "Attributes" >> "ammo"));
    };
    private _texture = getText(_cfg >> "Attributes" >> "textures");
    If !(_texture isEqualTo "") then {
        _object setObjectTextureGlobal [0, _texture];
    };

    //private _objectInit = getText(_curCfg >> "Attributes" >> "init");
    private _disableSimulation = [false,true] select (getNumber(_curCfg >> "Attributes" >> "disableSimulation"));
    _object enableSimulationGlobal (!_disableSimulation);

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
