/*
	Author: iJesuz
	
	Description:

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

private ["_dest", "_task_array", "_dest_name", "_dest_radius", "_base", "_crate", "_description", "_counter", "_i", "_sol", "_civ"];

params ["_dest", "_task_array", "_dest_name"];

// Build Barricades

_fnc_barricades = {
	private ["_road_pos", "_buffer", "_i", "_temp_pos", "_dest", "_dest_radius", "_veh", "_alpha", "_beta", "_gamma", "_p1", "_p2"];

	_dest = _this select 0;
	_dest_radius = _this select 1;

	_road_pos = [];
	_buffer = [];
	_i = 1;

	// fill _road_pos with positions on roads around _dest with radius _dest_radius
	while {_i < 3600} do {
		_i = _i / 10;
		_temp_pos = [ (_dest select 0) + (sin (_i) * _dest_radius) , (_dest select 1) + (cos (_i) * _dest_radius) ];
		if ( (isOnRoad _temp_pos) AND ((count _buffer) == 0) ) then {
			_buffer = _temp_pos;
		};
		if ( (!isOnRoad _temp_pos) AND ((count _buffer) > 0) ) then {
			_road_pos = _road_pos + [[ ((_buffer select 0) + ((_dest select 0) + (sin (_i-1) * _dest_radius))) / 2, ((_buffer select 1) + ((_dest select 1) + (cos (_i-1) * _dest_radius))) / 2]];
			_buffer = [];
		};
		_i = _i * 10 + 1;
	};

	{
		_veh = "Land_Razorwire_F" createVehicle (_x + [0]);
		_alpha = atan ( ((_dest select 0) - (_x select 0)) / ((_dest select 1) - (_x select 1)) );
		_veh setDir _alpha;

		_buffer = [(_x select 0) + (sin (_alpha) * 3), (_x select 1) + (cos (_alpha) * 3), 0];

		_beta = _alpha + 90;
		_p1 = [(_buffer select 0) + (sin (_beta) * 3), (_buffer select 1) + (cos (_beta) * 3), 0];
		_veh = "Land_CncBarrier_F" createVehicle _p1;
		_veh setDir _alpha;

		_gamma = _alpha + 270;
		_p2 = [(_buffer select 0) + (sin (_gamma) * 3), (_buffer select 1) + (cos (_gamma) * 3), 0];
		_veh = "Land_CncBarrier_F" createVehicle _p2;
		_veh setDir _alpha;

		// spawn mines around barricade ?
	} forEach _road_pos;
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

_base = getMarkerPos "respawn_west";

_crate = "B_Slingload_01_Cargo_F" createVehicle _base;
clearWeaponCargo _crate;
clearBackpackCargo _crate;
clearItemCargo _crate;
clearMagazineCargo _crate;
_crate addItemCargo ["ACE_Banana",1];
SETVAR(_crate,DORB_ISTARGET,true);

_description = "Eine kleine abtrünnige Einheit der AAF hat eine Stadt besetzt und terrorisiert die Einwohner. Befreien Sie die Stadt bevor eine standfeste Verteidigung errichtet werden kann und liefern sie Unterstützung für die wenigen Bürger, die der Besatzung nicht zum Opfer fiehlen!";
[-1,{_this spawn FM(disp_info)},["Nebenmission",["Vorräte"],"",true]] FMP;
#ifdef TEST
	LOG("[SIDEBY] Supplies erstellt!");
#else
	[_task_array, true, [_description, "Unterstützungslieferung", "Liefern"], _dest,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

// create civs and soldiers

#ifdef TEST
	private ["_marker"];
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
		_sol = (createGroup DORB_SIDE) createUnit [[_inf,_infw] call BIS_fnc_selectRandomWeighted, _pos, [], 0, "FORM"];
		_sol setDir (random 360);
	} else {
		_sol = (createGroup DORB_SIDE) createUnit [[_inf,_infw] call BIS_fnc_selectRandomWeighted, _pos, [], 0, "FORM"];
		_sol setDir (random 360);
	};

	#ifdef TEST
		_marker = createMarker [FORMAT_1("marker_inf_%1", _i), _pos];
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorIndependent";
	#endif

	_pos = [_dest+[0], _dest_radius, 0] call FM(random_pos);
	if ((random 9) > 4) then {
		_building = nearestBuilding _pos;
		_pos = ( [_building] call BIS_fnc_buildingPositions ) SELRND;
		_civ = (createGroup civilian) createUnit [_civs SELRND, _pos, [], 0, "FORM"];
		_civ setUnitPos "MIDDLE";
		_civ disableAI "MOVE";
		_civ setDir (random 360);
		SETPVAR(_civ, DORB_ISTARGET, true);
	} else {
		_civ = (createGroup civilian) createUnit [_civs SELRND, _pos, [], 0, "FORM"];
		_civ setDamage 1;
		_civ setDir (random 360);
		SETPVAR(_civ, DORB_ISTARGET, true);
	};

	#ifdef TEST
		_marker = createMarker [FORMAT_1("marker_civ_%1", _i), _pos];
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorCivilian";
	#endif
};

_counter = 0;
while {((_dest distance (position _crate)) > 25) AND ((damage _crate) < 1)} do {
	uiSleep 5;
	_counter = _counter + 5;
	if (_counter > 360) exitWith {};
};

if (((damage _crate) < 1) AND (_crate != objNull) AND (_counter < 360)) then {
	[-1,{_this spawn FM(disp_info)},["Nebenmission",["abgeschlossen"],"",true]] FMP;
	#ifdef TEST
		LOG("[SIDEBY] Supplies abgeschlossen!");
	#else
		[(_task_array select 0), "Succeeded", true] call BIS_fnc_taskSetState;
	#endif
} else {
	[-1,{_this spawn FM(disp_info)},["Nebenmission",["fehlgeschlagen"],"",true]] FMP;
	#ifdef TEST
		LOG("[SIDEBY] Supplies gescheitert!");
	#else
		[(_task_array select 0), "Failed", true] call BIS_fnc_taskSetState;
	#endif
};

deleteVehicle _crate;
