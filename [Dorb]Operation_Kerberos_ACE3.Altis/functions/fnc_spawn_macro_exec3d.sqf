/*
	Author: Dorbedo

	Description:
		Spawns predefined defencepositions

	Parameter(s):
		0 :	ARRAY	- Startpos
		1 : ARRAY 	- ConfigArray
		2 : SCALAR	- Centerdirection

*/
#include "script_component.hpp"

params[["_centerpos",[],[[]],[3]],["_configarray",[],[[]]],["_centerdir",9999,[0]]];
CHECK(_centerpos isEqualTo [])
CHECK(_configarray isEqualTo [])
private["_config","_material","_vehicles","_soldiers","_gruppe","_centerposASL"];

If (_centerdir > 9000) then {_centerdir = random 360;};
_config = [_configarray,missionconfigfile] call BIS_fnc_configPath;

_material = getArray(_config >> "material");
_vehicles = getArray(_config >> "vehicles");
_soldiers = getArray(_config >> "soldiers");
_gruppe = grpNull;
If (((count _vehicles)>0)||((count _soldiers)>0)) then {
	_gruppe = createGroup dorb_side;
};
_centerposASL = ATLtoASL _centerpos;
{
	private["_currentDir","_currentOffset","_currentPos","_currentType","_currentVectorUp","_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
	_currentType = (_x select 0);
	_currentPos = (_x select 1);
	_currentDir = (_x select 2);
	_currentOffset = (_x select 3);
	_currentVectorUp = (_x select 4);
	If (!(_currentOffset isEqualTo [0,0,0])) then {
		private["_rotateVector","_refpos","_terrainNormal","_VectorCorrection"];
		_rotateVector = [[(_currentPos select 0),(_currentPos select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
		_rotateVector set[2,(_currentPos select 2)];
		_refpos = _centerposASL VectorAdd _rotateVector;
		_rotateVector = [[(_currentOffset select 0),(_currentOffset select 1)],(360-_centerdir)] call BIS_fnc_rotateVector2D;
		_rotateVector set[2,(_currentOffset select 2)];
		_spawnPos = _refpos VectorAdd _rotateVector;
		_terrainNormal = surfaceNormal _refpos;
		_VectorCorrection = _terrainNormal VectorDiff _currentVectorUp;
		_spawnPos = _spawnPos VectorAdd _VectorCorrection;
		_spawnVector = _terrainNormal;
		_spawndir = (_currentDir + _centerdir) + 180;
		_spawnPosATL = ASLtoATL _spawnPos;
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
		_spawndir = (_currentDir + _centerdir) + 180 ;
		_spawnPosATL = ASLtoATL _spawnPos;
		_spawnPosATL set[2,(_currentPos select 2)];
	};
	_vehicle = createVehicle[format["%1",_currentType],_spawnPosATL, [], 0, "CAN_COLLIDE"];
	_vehicle setPosATL _spawnPosATL;
	_vehicle setDir _spawndir;
	_vehicle setVectorUP _spawnVector;
	SETPVAR(_vehicle,R3F_LOG_disabled,true);
}forEach _material;

{
	private["_currentDir","_currentOffset","_currentPos","_currentType","_currentVectorUp","_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
	_currentType = (_x select 0);
	_currentPos = (_x select 1);
	_currentDir = (_x select 2);
	_currentOffset = (_x select 3);
	_currentVectorUp = (_x select 4);
	If (!(_currentOffset isEqualTo [0,0,0])) then {
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
		_spawnPosATL = ASLtoATL _spawnPos;
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
	private "_vehicle";
	_vehicle = createVehicle[format["%1",_currentType],_spawnPosATL, [], 0, "CAN_COLLIDE"];
	_vehicle setPosATL _spawnPosATL;
	_vehicle setDir _spawndir;
	_vehicle setVectorUP _spawnVector;
	If (!(_vehicle isKindOf "Static")) then {
		_vehicle setFuel 0;
		_vehicle lock 3;
	};
	[_vehicle,_gruppe] call FM(spawn_crew);
}forEach _vehicles;

{
	private["_currentDir","_currentOffset","_currentPos","_currentType","_currentVectorUp","_spawnPos","_spawnPosATL","_spawnVector","_spawndir"];
	_currentType = (_x select 0);
	_currentPos = (_x select 1);
	_currentDir = (_x select 2);
	_currentOffset = (_x select 3);
	_currentVectorUp = (_x select 4);
	If (!(_currentOffset isEqualTo [0,0,0])) then {
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
		_spawnPosATL = ASLtoATL _spawnPos;
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
	_currentType = dorb_menlist SELRND;
	_unit = _gruppe createUnit[_currentType,_spawnPosATL, [], 0, "NONE"];
	_unit setPosATL _spawnPosATL;
	_unit setDir _spawndir;
	doStop _unit;
}forEach _soldiers;