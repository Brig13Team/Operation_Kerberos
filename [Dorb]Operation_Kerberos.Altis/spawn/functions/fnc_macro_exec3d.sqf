/*
    Author: Dorbedo

    Description:
        Spawns predefined defencepositions

    Parameter(s):
        0 :    ARRAY    - Startpos
        1 : ARRAY     - ConfigArray
        2 : SCALAR    - Centerdirection

    [(getMarkerPos "testmarker"),["missionConfigFile","defence_positions","terrain","bunker_medium"],0] execVM "functions\fnc_spawn_macro_exec3d";
    
*/
#include "script_component.hpp"
SCRIPT(macro_exec3D);
params[["_centerpos",[],[[]],[3]],["_configarray",[],[[]]],["_centerdir",9999,[0]]];
CHECK((_centerpos isEqualTo [])||(_configarray isEqualTo []))

If (_centerdir > 9000) then {_centerdir = random 360;};
private _config = [_configarray,missionconfigfile] call BIS_fnc_configPath;

private _material = getArray(_config >> "material");
private _vehicles = getArray(_config >> "vehicles");
private _soldiers = getArray(_config >> "soldiers");
private _gruppe = grpNull;

If (((count _vehicles)>0)||((count _soldiers)>0)) then {
    _gruppe = createGroup GVARMAIN(side);
    SETVAR(_gruppe,EGVAR(headquarter,state),"defence");
    SETVAR(_gruppe,EGVAR(headquarter,target),"_centerpos");
};
private _centerposASL = ATLtoASL _centerpos;

////// Defence Material
{
    _x params ["_currentType","_currentPos","_currentDir","_currentOffset","_currentVectorUp"];
    private["_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
    If (!(_currentOffset isEqualTo [0,0,0])) then {
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
        _spawnPosATL = [
                        ((_spawnPosATL select 0)+(_currentOffset select 0)),
                        ((_spawnPosATL select 1)+(_currentOffset select 1)),
                        ((_spawnPosATL select 2)+(abs(_currentOffset select 2)))
                        ];
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        /*
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _rotateVector = [[(_currentOffset select 0),(_currentOffset select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,abs(_currentOffset select 2)];
        _spawnPos = _refpos VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _spawnPos VectorAdd _VectorCorrection;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        _spawnPosATL = ASLtoATL _spawnPos;
        
        */
        
    }else{
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        //_spawnPos = _refpos;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
    };
    _vehicle = createVehicle[format["%1",_currentType],_spawnPosATL, [], 0, "CAN_COLLIDE"];
    If (_currentType in ["rhs_p37","rhs_prv13"]) then {EGVAR(headquarter,radars) pushback _vehicle};
	_vehicle enableSimulation false;
    _vehicle setVectorUP _spawnVector;
    _vehicle setPosATL _spawnPosATL;
    _vehicle setDir _spawndir;
}forEach _material;

//// Vehicles
{
    private["_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
    _x params ["_currentType","_currentPos","_currentDir","_currentOffset","_currentVectorUp"];
    If (!(_currentOffset isEqualTo [0,0,0])) then {
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
        _spawnPosATL = [
                        ((_spawnPosATL select 0)+(_currentOffset select 0)),
                        ((_spawnPosATL select 1)+(_currentOffset select 1)),
                        ((_spawnPosATL select 2)+(abs(_currentOffset select 2))+0.1)
                        ];
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        /*
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],_centerdir] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _rotateVector = [[(_currentOffset select 0),(_currentOffset select 1)],_centerdir] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,abs(_currentOffset select 2)];
        _spawnPos = _refpos VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _spawnPos VectorAdd _VectorCorrection;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        _spawnPosATL = ASLtoATL _spawnPos;*/
    }else{
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        _spawnPos = _refpos;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180 ;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
    
    };
    private _vehicle = createVehicle[format["%1",_currentType],_spawnPosATL, [], 0, "CAN_COLLIDE"];
	If ("Artillery" in getArray(configFile>>"cfgVehicles">>_currentType>>"availableforsupporttypes")) then {[_vehicle] call EFUNC(headquarter,fdc_register);};
    _vehicle enableSimulation false;
    _vehicle setPosATL _spawnPosATL;
    _vehicle setDir _spawndir;
    //_vehicle setVectorUP _spawnVector;
    _vehicle setVectorUP [0,0,1];
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
}forEach _vehicles;

{
    private["_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
    _x params ["_currentType","_currentPos","_currentDir","_currentOffset","_currentVectorUp"];
    If (!(_currentOffset isEqualTo [0,0,0])) then {
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
        _spawnPosATL = [
                        ((_spawnPosATL select 0)+(_currentOffset select 0)),
                        ((_spawnPosATL select 1)+(_currentOffset select 1)),
                        ((_spawnPosATL select 2)+(abs(_currentOffset select 2)))
                        ];
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        /*
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],_centerdir] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _rotateVector = [[(_currentOffset select 0),(_currentOffset select 1)],_centerdir] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,abs(_currentOffset select 2)];
        _spawnPos = _refpos VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _spawnPos VectorAdd _VectorCorrection;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180;
        _spawnPosATL = ASLtoATL _spawnPos;*/
    }else{
        private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
        _rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
        _rotateVector set[2,(_currentPos select 2)];
        _refpos = _centerposASL VectorAdd _rotateVector;
        _terrainNormal = surfaceNormal _refpos;
        _VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
        _spawnPos = _refpos VectorAdd _VectorCorrection;
        _spawnPos = _refpos;
        _spawnVector = _terrainNormal;
        _spawndir = (_currentDir + _centerdir) + 180 ;
        _spawnPosATL = ASLtoATL _spawnPos;
        _spawnPosATL set[2,(_currentPos select 2)];
    
    };
    private "_unit";
    /*
        TO DO: 
            - generate a new soldiert, if side of soldier is not matching
            - solder should have similar equipment
    */
    _currentType = GVAR(list_soldiers) SELRND;
    _unit = _gruppe createUnit[_currentType,_spawnPosATL, [], 0, "NONE"];
    _unit setPosATL _spawnPosATL;
    _unit setDir _spawndir;
}forEach _soldiers;