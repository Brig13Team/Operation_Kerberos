/*
    Author: Dorbedo

    Description:
        Spawns predefined defencepositions

    Parameter(s):
        0 : ARRAY    - Startpos
        1 : ARRAY     - ConfigArray
        2 : SCALAR    - Centerdirection

    [(getMarkerPos "testmarker"),["missionConfigFile","defence_positions","terrain","bunker_medium"],0] execVM "functions\fnc_spawn_macro_exec3d";
    
*/
#include "script_component.hpp"
SCRIPT(exec_housemacro);
_this params [ ["_house",objNull,[objNull]],["_material",[],[[]]],["_vehicles",[],[[]]],["_soldiers",[],[[]]] ];

If (isNull _house) exitWith {};

_houseType = typeOf _house;
_housePos = getPosASL _house;

([_house] call FUNC(getRollPitchYaw)) params ["_houseRoll","_housePitch","_houseYawn"];
If (((count _vehicles)>0)||((count _soldiers)>0)) then {
    _gruppe = createGroup GVARMAIN(side);
    SETVAR(_gruppe,EGVAR(headquarter,state),"defend");
    SETVAR(_gruppe,EGVAR(headquarter,target),_centerpos);
};

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentRotMat",[],[[]]]  ];
    ([_currentRotMat] call FUNC(convertRotMatToAngle)) params ["_currentRoll","_currentPitch","_currentYaw"];
    private _setPos = _currentPos vectorAdd _housePos;
    
    _currentRoll = _currentRoll + _houseRoll;
    _currentPitch = _currentPitch + _housePitch;
    _currentYaw = _currentYaw + _houseYawn;
    
    private _setUp = [sin _currentRoll,0,cos _currentRoll];
    private _setDir = [0,cos _currentPitch,sin _currentPitch];
    _setUp = [_setUp,_currentYaw] call FUNC(rotateVectorXY);
    _setDir = [_setDir,_currentYaw] call FUNC(rotateVectorXY);
    
    private _vehicle = createVehicle [_currentType,_spawnPosATL, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setVectorUP _setUp;
    _vehicle setVectorDir _setDir;
    _vehicle setPosATL _setPos;
} forEach _material;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentRotMat",[],[[]]]  ];
    ([_currentRotMat] call FUNC(convertRotMatToAngle)) params ["_currentRoll","_currentPitch","_currentYaw"];
    private _setPos = _currentPos vectorAdd _housePos;
    
    _currentRoll = _currentRoll + _houseRoll;
    _currentPitch = _currentPitch + _housePitch;
    _currentYaw = _currentYaw + _houseYawn;
    
    private _setUp = [sin _currentRoll,0,cos _currentRoll];
    private _setDir = [0,cos _currentPitch,sin _currentPitch];
    _setUp = [_setUp,_currentYaw] call FUNC(rotateVectorXY);
    _setDir = [_setDir,_currentYaw] call FUNC(rotateVectorXY);
    
    private _vehicle = createVehicle [_currentType,_spawnPosATL, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setVectorUP _setUp;
    _vehicle setVectorDir _setDir;
    _vehicle setPosATL _setPos;
    If ("Artillery" in getArray(configFile>>"cfgVehicles">>_currentType>>"availableforsupporttypes")) then {[_vehicle] call EFUNC(headquarter,fdc_register);};
    _vehicle enableSimulation true;
    [_vehicle,_gruppe] call FUNC(crew);
    If (!(_vehicle isKindOf "StaticWeapon")) then {
        _vehicle setFuel 0;
        _vehicle lock 3;
    }else{
        _vehicle lock 0;
        private["_watchpos"];
        _watchpos = [_spawnPos,250,_spawndir] call BIS_fnc_relPos;
        _watchpos set[2,0];
        (gunner _vehicle) doWatch (_watchpos);
    };
} forEach _vehicles;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentRotMat",[],[[]]]  ];
    ([_currentRotMat] call FUNC(convertRotMatToAngle)) params ["_currentRoll","_currentPitch","_currentYaw"];
    private _setPos = _currentPos vectorAdd _housePos;
    
    _currentRoll = _currentRoll + _houseRoll;
    _currentPitch = _currentPitch + _housePitch;
    _currentYaw = _currentYaw + _houseYawn;
    
    private _setUp = [sin _currentRoll,0,cos _currentRoll];
    private _setDir = [0,cos _currentPitch,sin _currentPitch];
    _setUp = [_setUp,_currentYaw] call FUNC(rotateVectorXY);
    _setDir = [_setDir,_currentYaw] call FUNC(rotateVectorXY);
    
    private _currentType = GVAR(list_soldiers) SELRND;
    private _unit = _gruppe createUnit[_currentType,_spawnPosATL, [], 0, "NONE"];
    _unit setPosATL _spawnPosATL;
    _unit setVectorUP _setUp;
    _unit setVectorDir _setDir;
    _unit setPosATL _setPos;
} forEach _soldiers;
