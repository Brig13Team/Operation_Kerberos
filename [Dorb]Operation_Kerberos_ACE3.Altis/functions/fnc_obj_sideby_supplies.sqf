/*
	Author: iJesuz
	
	Description:

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
		2 : String - Name des Ziels
*/
#include "script_component.hpp"

SCRIPT(obj_sideby_supplies);

private ["_dest", "_task_array", "_dest_name", "_dest_radius", "_base", "_crate", "_description", "_counter", "_i", "_sol", "_civ", "_inf", "_infw", "_civs", "_fnc_barricades"];

params ["_dest", "_task_array", "_dest_name"];

DORB_SIDEBY_OBJECTS = [];

// Build Barricades

_fnc_barricades = {
	private ["_roads", "_buffer", "_alpha", "_beta", "_gamma", "_dir", "_veh", "_p1", "_p2", "_isConnectedToOne", "_i", "_buffer2"];

	params ["_dest", "_dest_radius"];

	_isConnectedToOne = {
			private["_buf"];
			_buf = false;
			params ["_elem", "_array"];
			{
				if (_x in (roadsConnectedTo _elem)) then {
					_buf = true;
				};
			} forEach _array;
			_buf
		};

	#ifdef TEST
		private ["_marker"];
	#endif

	// get all roads in radius
	_roads = _dest nearRoads _dest_radius;

	// remove all roads which are to near
	_buffer = [];
	{
		if (abs(_dest_radius - (_dest distance _x)) <= 25) then {
			_buffer pushBack _x;
		};
	} forEach _roads;

	_roads = +_buffer;
	_buffer = +_roads;

	// eleminate roads connecteded to eachother so that only one of them is left
	{
		if ([_x,_roads - [_x]] call _isConnectedToOne) then {
			_roads = _roads - [_x];
		};
	} forEach _buffer;

	// spawn barricades
	{
		_position = position _x;
		_alpha = [_x, (roadsConnectedTo _x) select 0] call BIS_fnc_dirTo;

		_veh = createVehicle ["Land_Razorwire_F", _position, [], 0, "NONE"];
		DORB_SIDEBY_OBJECTS pushBack _veh;
		_veh setDir _alpha;
		_veh setPos _position;

		_buffer = [(_position select 0) + (sin (_alpha) * 3), (_position select 1) + (cos (_alpha) * 3), 0];

		_beta = _alpha + 90;
		_p1 = [(_buffer select 0) + (sin (_beta) * 3), (_buffer select 1) + (cos (_beta) * 3), 0];
		_veh = createVehicle ["Land_CncBarrier_F", _p1, [], 0, "NONE"];
		DORB_SIDEBY_OBJECTS pushBack _veh;
		_veh setDir _alpha;
		_veh setPos _p1;

		_gamma = _alpha + 270;
		_p2 = [(_buffer select 0) + (sin (_gamma) * 3), (_buffer select 1) + (cos (_gamma) * 3), 0];
		_veh = createVehicle ["Land_CncBarrier_F", _p2, [], 0, "NONE"];
		DORB_SIDEBY_OBJECTS pushBack _veh;
		_veh setDir _alpha;
		_veh setPos _p2;

		#ifdef TEST
			_marker = createMarker [FORMAT_2("marker_road_%1_%2", _dest_radius, _forEachIndex), _position];
			DORB_SIDEBY_OBJECTS pushBack _marker;
			_marker setMarkerType "hd_arrow";
			_marker setMarkerColor "ColorOPFOR";
			_marker setMarkerDir _alpha;
		#endif
	} forEach _roads;
};

if (isClass(configFile >> "CfgWorlds" >> worldName >> "Names" >> _dest_name)) then {
	_dest_radius = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _dest_name >> "radiusA");
} else {
	_dest_radius = 200;
};
[_dest,_dest_radius] call _fnc_barricades;

if (isClass(configFile >> "CfgWorlds" >> worldName >> "Names" >> _dest_name)) then {
	_dest_radius = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _dest_name >> "radiusB");
} else {
	_dest_radius = 100;
};
[_dest,_dest_radius] call _fnc_barricades;

// continue with spawning the missions core

_base = getMarkerPos "rescue_marker";

_crate = createVehicle["B_Slingload_01_Cargo_F",_base,[],0,"NONE"];
DORB_SIDEBY_OBJECTS pushBack _crate;
clearWeaponCargo _crate;
clearBackpackCargo _crate;
clearItemCargo _crate;
clearMagazineCargo _crate;
_crate addItemCargo ["ACE_Banana",1];
SETVAR(_crate,DORB_ISTARGET,true);

["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_SUPPLIES_DESCRIPTION_SHORT"],"",false] call FM(disp_info_global);
#ifdef TEST
	LOG("[SIDEBY] Supplies erstellt!");
#else
	[_task_array, true, ["STR_DORB_SIDE_SUPPLIES_DESCRIPTION", "STR_DORB_SIDE_SUPPLIES_DESCRIPTION_SHORT", "STR_DORB_SIDE_SUPPLIES_MARKER"], _dest,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

// create civs and soldiers
#ifdef TEST
	DORB_SIDE = east;
#endif

_inf = getArray (missionConfigFile >> "sideby_config" >> "supplies" >> "inf");
_infw = getArray (missionConfigFile >> "sideby_config" >> "supplies" >> "infw");
_civs = getArray (missionConfigFile >> "sideby_config" >> "supplies" >> "civs");

for "_i" from 1 to 25 do {
	_pos = [_dest+[0], _dest_radius, 0] call FM(random_pos);
	if ((random 9) > 4) then {
		_building = nearestBuilding _pos;
		_pos = ( [_building] call BIS_fnc_buildingPositions ) SELRND;
		private["_gruppe","_einheit"];
		_gruppe = (createGroup DORB_SIDE);
		_einheit = [_inf,_infw] call BIS_fnc_selectRandomWeighted;
		_sol = _gruppe createUnit [_einheit, _pos, [], 0, "FORM"];
		_sol setDir (random 360);
	} else {
		private["_gruppe","_einheit"];
		_gruppe = (createGroup DORB_SIDE);
		_einheit = [_inf,_infw] call BIS_fnc_selectRandomWeighted;
		_sol = _gruppe createUnit [_einheit, _pos, [], 0, "FORM"];
		_sol setDir (random 360);
	};

	_pos = [_dest+[0], _dest_radius, 0] call FM(random_pos);
	if ((random 9) > 4) then {
		_building = nearestBuilding _pos;
		_pos = ( [_building] call BIS_fnc_buildingPositions ) SELRND;
		private["_gruppe","_einheit"];
		_gruppe = (createGroup civilian);
		_einheit = _civs SELRND;
		_civ = _gruppe createUnit [_einheit, _pos, [], 0, "FORM"];
		_civ setUnitPos "MIDDLE";
		_civ disableAI "MOVE";
		_civ setDir (random 360);
		SETPVAR(_civ, DORB_ISTARGET, true);
	} else {
		private["_gruppe","_einheit"];
		_gruppe = (createGroup civilian);
		_einheit = _civs SELRND;
		_civ = _gruppe createUnit [_einheit, _pos, [], 0, "FORM"];
		_civ setDamage 1;
		_civ setDir (random 360);
		SETPVAR(_civ, DORB_ISTARGET, true);
	};

	DORB_SIDEBY_OBJECTS pushBack _sol;
	DORB_SIDEBY_OBJECTS pushBack _civ;
};


_counter = 0;
LOG("SCHLEIFE GESTARTET");
while { (!(DORB_SIDEBY_OBJECTS isEqualTo [])) AND {((_dest distance (position _crate)) > 25) AND ((damage _crate) < 1)} } do {
	uiSleep 30;
	_counter = _counter + 6;
	if (_counter > 360) exitWith {};
};
LOG("SCHLEIFE ABGEBROCHEN");
if (DORB_SIDEBY_OBJECTS isEqualTo []) exitWith {};

if (((damage _crate) < 1) AND (_crate != objNull) AND (_counter < 360)) then {
	["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FINISHED"],"",false] call FM(disp_info_global);
	#ifdef TEST
		LOG("[SIDEBY] Supplies abgeschlossen!");
	#else
		[(_task_array select 0), "Succeeded", true] call BIS_fnc_taskSetState;
		[_main_task select 1, "targets", [2,50]] call FM(obj_reward);
	#endif
} else {
	["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FAILED"],"",false] call FM(disp_info_global);
	#ifdef TEST
		LOG("[SIDEBY] Supplies gescheitert!");
	#else
		[(_task_array select 0), "Failed", true] call BIS_fnc_taskSetState;
	#endif
};

deleteVehicle _crate;
