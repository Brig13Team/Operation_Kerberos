/*
	Author: Dorbedo
	
	Description:
		
		- Weights the Roads, selects important Roadpositions,
		- sends Veh-Patrols,Inf-Patrols
		
	
	Parameter(s):
		0 : ARRAY		- formatted Road-Array
		1 : ARRAY or BOOL	- (true) for automatic or the unique amounts [patrols,fortifications,ieds]
		2 : BOOL			- spawn Fortifications
		3 : BOOL			- spawn IEDs
		4 : BOOL			- spawn Civ-Vehicles
		5 : BOOL			- spawn Trash
		
	Returns:
		BOOL
	/// TO DO: make extension
*/
#include "script_component.hpp"
/// amounts: [patrols,fortifications,ieds]
params[["_roadArray",[],[[]]],["_amounts",[0,0,0],[[],true],[3]],["_fortifications",false,[true]],["_IEDs",false,[true]],["_civVehicles",false,[true]],["_trash",false,[true]]];

/// Exit if there is no roadarray or all options are turned off
CHECK(_roadArray isEqualTo [])
CHECK(!(_fortifications||_IEDs||_civVehicles||_trash))
If ((IS_ARRAY(_amounts))&&{(((_amounts select 0)==0)&&((_amounts select 1)==0)&&((_amounts select 2)==0))}) exitWith {};
If ((IS_BOOL(_amounts))&&{!_amounts}) exitWith {};

/// Set Amounts
_roadcount = count _roadArray;

/// only 33% of the roads should have something
_max_amount = floor(_roadCount/3) max 1;
CHECK(_max_amount <= 2)

/// set/check the spawn-amounts
If (IS_ARRAY(_amounts)) then {
	_amount = 0;
	If (_amounts select 0 > 0) then {_amount = _amount + (_amounts select 0);};
	If (_amounts select 1 > 0) then {_amount = _amount + (_amounts select 1);};
	If (_amounts select 2 > 0) then {_amount = _amount + (_amounts select 2);};

	/// If there are not enough roads the amounts are reduced. The automatic function is ignored
	If (_amount > _max_amount) then {
		If (_amounts select 0 > 0) then {_amounts set [0,(((_amounts select 0)/_amount)*(_max_amount))];}else{_amounts set [0,0];};
		If (_amounts select 1 > 0) then {_amounts set [1,(((_amounts select 1)/_amount)*(_max_amount))];}else{_amounts set [1,0];};
		If (_amounts select 2 > 0) then {_amounts set [2,(((_amounts select 2)/_amount)*(_max_amount))];}else{_amounts set [2,0];};
	};
}else{
	private["_count_IEDs","_count_fortifications","_count_patrols"];
	_count_fortifications = ((floor(_max_amount/4)) min 7) max 1;
	_count_IEDs = ((floor(_max_amount/3))min 20) max 1;
	_count_patrols = (floor(_max_amount - _count_IEDs - _count_fortifications)) max 0;	
	/*
		Reduce the max Unitamount
		at this state, it's reduced to half of the max unitcount
		max unitcount = 100 + 20*diffuculty
		patrols of 4
		
		
	*/
	private "_difficulty";
	_difficulty = [] call FM(dyn_difficulty);
	_count_patrols = (floor(((100 + 20*_difficulty)/2)/4)) min _count_patrols;

	_amounts = [_count_patrols,_count_fortifications,_count_IEDs];
};


//// Weight the Roadpositions
_weightdistance = 25;
_roadArray_weighted = [];



for "_i" from 0 to ((count _roadArray)-1) do {
	_currentRoadArray = _roadArray select _i;
	_current_pos = (_currentRoadArray select 0);
	_current_dir = _currentRoadArray select 1;
	_current_size = _currentRoadArray select 2;
	
	_current_weight = (_currentRoadArray select 2)*5;
	{
		If ((((_x select 0)) distance _current_pos) < _weightdistance) then {
			_current_weight = _current_weight + (((_x select 2)+1)*2);
		};
	}forEach _roadArray;
	_current_pos params ["_cur_x","_cur_y","_cur_z"];
	_roadArray_weighted pushBack [_current_weight,_cur_x,_cur_y,_cur_z,_current_dir,_current_size];
};

//// Sort

_roadArray_weighted sort false;

LOG_1(_roadArray_weighted);
//////// Generate spawn positions


//// get the good spots and have a minimum distance between them
_fortifications_distance = 150;

_fortifications_positions = [(_roadArray_weighted select 0)];
_roadArray_weighted deleteAt 0;

for "_i" from 0 to (_amounts select 1) do {
	_add_pos = -1;
	for [{_j= 0},{_j < (count _roadArray_weighted)},{_j = _j + 1}] do {
		_add = 0;
		_add = {If(([((_roadArray_weighted select _j)select 1),((_roadArray_weighted select _j)select 2),((_roadArray_weighted select _j)select 3)]distance[(_x select 1),(_x select 2),(_x select 3)])<_fortifications_distance) then {true}else{false}}count _fortifications_positions;
		If (_add<1) then {_add_pos = _j;};
	};
	If (_add_pos > 0) then {
		_fortifications_positions pushBack (_roadArray_weighted select _add_pos);
		_roadArray_weighted deleteAt _add_pos;
	};
};

_roadArray_weighted = _roadArray_weighted call BIS_fnc_arrayShuffle;


//// IEDs
_IEDs_positions = [];
for "_i" from 0 to (_amounts select 2) do {
	_temp = _roadArray_weighted call BIS_fnc_arrayPop;
	_IEDs_positions pushBack _temp;
};

_patrol_positions = [];
//// Patrols
for "_i" from 0 to (_amounts select 0) do {
	_patrol_positions pushBack (_roadArray_weighted select _i);
};


///// spawn everything
/// fortifications
If (_fortifications) then {
	{
		_x call FM(city_fortify_roads_defence);
	}forEach _fortifications_positions;
};

/// IEDs
If (_IEDs) then {
	//create IED-Array
	_IED_array = [];
	{
		_rand = floor(random 2);
		_spawndir = (_x select 4);
		If (_rand>0) then {_spawndir = _spawndir + 90;}else{_spawndir = _spawndir - 90;};
		_spawndistance = switch ((_x select 5)) do {
			case 1 : {((random 4)+1.5)};
			case 2 : {((random 5)+1.5)};
			default {((random 3)+1.5)};
		};
		_spawnpos = [[(_x select 1),(_x select 2),(_x select 3)], _spawndistance, _spawndir] call BIS_fnc_relPos;
		_spawnpos set[3,(random 360)];
		_spawnpos set[2,0];
		_IED_array pushBack _spawnpos;
	}forEach _IEDs_positions;
	[_IED_array,3] call FM(city_spawn_explosives);
};
/// Civ-Vehicles
if (_civVehicles) then {
	for "_i" from 0 to (floor(((_amounts select 0))/3)) do {
		_einheit = dorb_civ_cars SELRND;
		_rand = floor(random 2);
		_spawndir = ((_roadArray_weighted select _i)select 4);
		If (_rand>0) then {_spawndir = _spawndir + 90;}else{_spawndir = _spawndir - 90;};
		
		_spawnpos = [((_roadArray_weighted select _i)select 1),((_roadArray_weighted select _i)select 2),((_roadArray_weighted select _i)select 3)];
		_veh = createVehicle [_einheit,_spawnpos, [], 0, "CAN_COLLIDE"];
		_distance = switch (((_roadArray_weighted select _i)select 5)) do {
			case 1 : {4.5};
			case 2 : {5.5};
			default {3.5};
		};
		_newpos = [_spawnpos, _distance, _spawndir] call BIS_fnc_relPos;
		_dir = ((_roadArray_weighted select _i)select 4);
		_veh setDir _dir;
		_newpos set[2,0.2];
		_veh setPosATL _newpos;
		
		If (dorb_debug) then {
			_mrkr = createMarker [format["CivVehiclesRoadside-%1",_newpos],_newpos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorCivilian";
			_mrkr setMarkerType "b_motor_inf";
		};
	};
};
/// Patrols

_roadArray_weighted = _roadArray_weighted call BIS_fnc_arrayShuffle;

for "_i" from 0 to (floor(((_amounts select 0))/3)) do {
	
	_spawnpos = [((_roadArray_weighted select _i)select 1),((_roadArray_weighted select _i)select 2),0.1];
	
	_gruppe = createGroup dorb_side;
	for "_j" from 0 to 3 do {
		_typ = dorb_menlist SELRND;
		_spawnedunit = _gruppe createUnit [_typ,_spawnpos, [], 5, "NONE"];
	};
	
	for "_j" from 0 to 4 do {
		private ["_wp"];
		_temp = _roadArray_weighted call BIS_fnc_selectRandom;
		_newPos = [(_temp select 1),(_temp select 2),0];
		_wp = _gruppe addWaypoint [_newPos, _j];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 20;
		_wp setWaypointTimeout [10,15,20];
		if (_j == 0) then	{
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "STAG COLUMN";
			_wp setWaypointCombatMode "WHITE";
		};
	};
	private "_wp";
	_wp = _gruppe addWaypoint [_spawnpos, 0];
	_wp setWaypointType "CYCLE";

	If (dorb_debug) then {
		_mrkr = createMarker [format["Patrol-%1",_spawnpos],_spawnpos];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorOPFOR";
		_mrkr setMarkerType "o_inf";
	};
};

/// spawn trash
If (_trash) then {
	_trash_array = ["Land_Garbage_line_F","Land_Garbage_square3_F","Land_Garbage_square5_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F"];
	_roadArray_weighted = _roadArray_weighted call BIS_fnc_arrayShuffle;
	for "_i" from 0 to (floor(((_amounts select 0))/4)) do {
		_einheit = _trash_array SELRND;
		_rand = floor(random 2);
		_spawndir = ((_roadArray_weighted select _i)select 4);
		If (_rand>0) then {_spawndir = _spawndir + 90;}else{_spawndir = _spawndir - 90;};
		
		_spawnpos = [((_roadArray_weighted select _i)select 1),((_roadArray_weighted select _i)select 2),((_roadArray_weighted select _i)select 3)];
		_veh = createVehicle [_einheit,_spawnpos, [], 0, "CAN_COLLIDE"];
		_distance = switch (((_roadArray_weighted select _i)select 5)) do {
			case 1 : {((random 4)+1.5)};
			case 2 : {((random 5)+1.5)};
			default {((random 3)+1.5)};
		};
		_newpos = [_spawnpos, _distance, _spawndir] call BIS_fnc_relPos;
		_dir = ((_roadArray_weighted select _i)select 4);
		_veh setDir _dir;
		_newpos set[2,0];
		_veh setPosATL _newpos;
		
		If (dorb_debug) then {
			_mrkr = createMarker [format["Civtrash-%1",_newpos],_newpos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorCivilian";
			_mrkr setMarkerType "b_art";
		};
	};
};