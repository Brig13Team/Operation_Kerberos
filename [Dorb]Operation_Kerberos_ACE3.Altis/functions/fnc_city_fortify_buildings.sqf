/*
	Author: Dorbedo
	
	Description:
		
		- Mines, unit, statics in buildings
		
	
	Parameter(s):
		0 : ARRAY		- formatted Road-Array [typename, posASL]
		1 : ARRAY		- optionsarray
		
	Returns:
		BOOL
	/// TO DO: make extension
*/
#include "script_component.hpp"

params[["_buildingsarray_formatted",[],[[]]],["_optionsarray",[],[[]]]];
CHECK(_buildingsarray_formatted isEqualTo [])

_optionsarray params["_unit_min","_unit_max","_static_min","_static_max","_fortifications","_ieds","_mines","_vehicles"];

_unit_count = (floor(random(_unit_max-_unit_min)))+_unit_min;
_static_count = (floor(random(_static_max-_static_min)))+_static_min;

/*
	fortifications - no effect
	ieds - no effect
*/


private["_garages","_garages_types","_buildings"];
/// remove uninteresing buildings, sort out garages
_garages = [];
_buildings = [];
_garages_types = ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"];
{
	If ((_x select 0)in _garages_types) then {
		_garages pushBack _x;
	}else{
		If (!((_x select 0)isKindOf "Ruins")) then {
			_buildings pushBack _x;
		};
	};
}forEach _buildingsarray_formatted;


/// garages 
if (_vehicles) then {
	_garages = _garages call BIS_fnc_arrayShuffle;
	for "_i" from 0 to (floor(((count _garages)-1)/3)) do {
		private["_einheit","_spawnpos","_spawndir","_newpos","_veh"];
		_einheit = dorb_civ_cars_garage SELRND;
		_spawnpos = ASLtoATL ((_garages select _i) select 1);
		_spawndir = ((_garages select _i) select 2)+90;
		_newpos = ASLtoATL((_garages select _i) select 1);
		_spawnpos set[2,((_spawnpos select 2)+2000)];
		_newpos set[2,((_newpos select 2)+0.5)];
		_veh = createVehicle[_einheit,_spawnpos, [], 0, "CAN_COLLIDE"];
		_veh setDir _spawndir;
		_veh setPosATL _newpos;
		If (dorb_debug) then {
			private "_mrkr";
			_mrkr = createMarker [format["CivVehiclesGarage-%1",_spawnpos],_spawnpos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorCivilian";
			_mrkr setMarkerType "b_motor_inf";
		};
	};
};


/// spawn units and statics
/*
	maximum of 3 units per hous
	aditional static possible
	maximum of 30 Mines
*/

_buildings = _buildings call BIS_fnc_arrayShuffle;
private ["_mines_count","_lastbuilding"];
_mines_count = -1;
If (_mines) then {
	_mines_count = (floor((count(_buildings))/2) min 30);
};
_lastbuilding = 0;
/// statics and units
for "_i" from 0 to ((count _buildings)-1) do {
	private["_current_dir","_current_posASL","_current_type","_buildingpos","_staticpos","_unitpos"];
	_current_type = (_buildings select _i) select 0;
	_current_posASL = (_buildings select _i) select 1;
	_current_dir = (_buildings select _i) select 2;
	_buildingpos = [];
	_buildingpos = getArray(missionConfigFile >> "city_defence" >> "buildings_vanilla" >> _current_type >> "soldierpos");
	_staticpos = [];
	_unitpos = [];
	If (!(_buildingpos isEqualTo [])) then {
		// look for static-positions
		private["_spawnamount","_gruppe"];
		{
			If (((_x select 5)==1)||(_x select 5)==3) then {
				_staticpos pushBack _x;
			}else{
				_unitpos pushBack _x;
			};
		}forEach _buildingpos;
		_spawnamount = -1;
		//If ((count _staticpos)>5) then {
		//	_spawnamount = 2 min _static_count;
		//}else{
			If (!(_staticpos isEqualTo [])) then {
				_spawnamount = 1 min _static_count;
			};
		//};
		_gruppe = createGroup dorb_side;
		/// spawn statics
		for "_j" from 0 to (_spawnamount -1) do {
			CHECK(_staticpos isEqualTo [])
			private ["_spawnposarray","_unit","_theta","_refpos","_spawnpos","_spawndir","_veh"];
			_staticpos = _staticpos call BIS_fnc_arrayShuffle;
			_spawnposarray = [_staticpos] call BIS_fnc_arrayShift;
			_unit = dorb_staticlist_high SELRND;
			LOG(FORMAT_1("Spawntyp = %1",(_spawnposarray select 5)));
			If ((_spawnposarray select 5)!=1) then {
				_unit = dorb_staticlist SELRND;
			};
			LOG_1(_unit);
			_theta = 360 - _current_dir;
			
			_refpos =  [		( (cos _theta)*(_spawnposarray select 0) - (sin _theta)*(_spawnposarray select 1) ),
							( (sin _theta)*(_spawnposarray select 0) + (cos _theta)*(_spawnposarray select 1) ),
							(_spawnposarray select 2)
						];

			
			_spawnpos = [		(_refpos select 0)+(_current_posASL select 0),
							(_refpos select 1)+(_current_posASL select 1),
							(_refpos select 2)+(_current_posASL select 2)
						];
			

			_spawnpos = ASLtoATL _spawnpos;
			If ((_spawnposarray select 4)>=0) then {
				_spawndir = ((_current_dir) + (_spawnposarray select 3));
				LOG(FORMAT_2("current_dir = %1 // _spawndir=%2",_current_dir,(_spawnposarray select 3)));
				LOG_1(_spawndir);
			}else{
				_spawndir = _current_dir + (( ( ( (_spawnposarray select 4)-(_spawnposarray select 3) )/2) ) + (_spawnposarray select 3) );
				LOG("nummer2");
			};
			LOG_1(_spawndir);
			_veh = createVehicle[_unit, _spawnpos, [], 0, "CAN_COLLIDE"];
			If (!(IS_SCALAR(_spawndir))) then {ERROR("Spawndir not scalar"); _spawndir = random(360);};
			_veh setDir _spawndir;
			LOG_1(_gruppe);
			[_veh,_gruppe] call FM(spawn_crew);
			
			If (dorb_debug) then {
				private "_mrkr";
				_mrkr = createMarker [format["buildings_static-%1",_spawnpos],_spawnpos];
				_mrkr setMarkerShape "ICON";
				_mrkr setMarkerColor "ColorGreen";
				_mrkr setMarkerType "hd_dot";
			};
			SETPVAR(_gruppe,asr_ai3_main_initgroupsize,1);
			DEC(_static_count);
		};
		/// spawn Units
		private "_rand";
		_rand = (floor(random 1))+1;
		_spawnamount = ((count(_staticpos)+count(_unitpos)) min _rand) min _unit_count;
		
		If (!(_staticpos isEqualTo [])) then {_unitpos append _staticpos;};
		
		for "_j" from 0 to _spawnamount do {
			private["_spawndir","_spawnposarray","_unit","_spawnpos","_spawnedunit","_theta","_refpos"];
			CHECK(_unitpos isEqualTo [])
			_unitpos = _unitpos call BIS_fnc_arrayShuffle;
			_spawnposarray = [_unitpos] call BIS_fnc_arrayShift;
			_unit = dorb_menlist SELRND;
			_theta = 360 - _current_dir;
			_refpos =  [		( (cos _theta)*(_spawnposarray select 0) - (sin _theta)*(_spawnposarray select 1) ),
							( (sin _theta)*(_spawnposarray select 0) + (cos _theta)*(_spawnposarray select 1) ),
							(_spawnposarray select 2)
						];

			
			_spawnpos = [		(_refpos select 0)+(_current_posASL select 0),
							(_refpos select 1)+(_current_posASL select 1),
							(_refpos select 2)+(_current_posASL select 2)
						];
			

			_spawnpos = ASLtoATL _spawnpos;
			If ((_spawnposarray select 4)>=0) then {
				_spawndir = _current_dir + (_spawnposarray select 3);
				LOG(FORMAT_2("current_dir = %1 // _spawndir=%2",_current_dir,(_spawnposarray select 3)));
			}else{
				_add = (( ( ( (_spawnposarray select 4) - (_spawnposarray select 3) )/2) ) + (_spawnposarray select 3) );
				_spawndir = _current_dir + _add;
			};
			
			_spawnedunit = _gruppe createUnit[_unit,_spawnpos, [], 0, "NONE"];
			_spawnedunit setDir _spawndir;
			If (!(_staticpos isEqualTo [])) then {doStop _spawnedunit;};
			[_gruppe] call FM(moveToHC);
			If (dorb_debug) then {
				private "_mrkr";
				_mrkr = createMarker [format["buildings_unit-%1",_spawnpos],_spawnpos];
				_mrkr setMarkerShape "ICON";
				_mrkr setMarkerColor "ColorRed";
				_mrkr setMarkerType "hd_dot";
			};
			DEC(_unit_count);
		};
		If ((_spawnamount>0)&&(_staticpos isEqualTo [])) then {
			[_gruppe,(getPos (leader _gruppe))] call FM(city_patrol_building);
		};
		If ((count (units _gruppe))<1) then {deleteGroup _gruppe;};
		
	};
	_lastbuilding = _i;
	CHECK((_unit_count<1)&&(_static_count<1))
};
private "_mines_spawnarray";
/// mines
_mines_spawnarray = [];
for "_i" from (_lastbuilding+1) to ((count _buildings)-1) do {
	If (_mines_count < 1) exitWith {};
	DEC(_mines_count);
	private ["_current_dir","_current_posASL","_current_type","_buildingpos","_doorpos"];
	_current_type = (_buildings select _i) select 0;
	_current_posASL = (_buildings select _i) select 1;
	_current_dir = (_buildings select _i) select 2;
	_buildingpos = [];
	_doorpos = [];
	//// igrnore buildings with doors, but no pos (e.g. Lamps)
	_buildingpos = getArray(missionConfigFile >> "city_defence" >> "buildings_vanilla" >> _current_type >> "soldierpos");
	If (!(_buildingpos isEqualTo [])) then {
		_doorpos = getArray(missionConfigFile >> "city_defence" >> "buildings_vanilla" >> _current_type >> "doorpos");
	};
	If (!(_doorpos isEqualTo [])) then {
		_doorpos = _doorpos call BIS_fnc_arrayShuffle;
		private "_rand";
		_rand = ((floor(random 1))+1) min ((count _doorpos)-1);
		for "_j" from 0 to (_rand) do {
			private ["_spawnposarray","_theta","_refpos","_spawnpos","_spawndir"];
			_spawnposarray = _doorpos select _j;
			_theta = 360 - _current_dir;
			
			_refpos =  [		( (cos _theta)*(_spawnposarray select 0) - (sin _theta)*(_spawnposarray select 1) ),
							( (sin _theta)*(_spawnposarray select 0) + (cos _theta)*(_spawnposarray select 1) ),
							(_spawnposarray select 2)
						];

			
			_spawnpos = [		(_refpos select 0)+(_current_posASL select 0),
							(_refpos select 1)+(_current_posASL select 1),
							(_refpos select 2)+(_current_posASL select 2)
						];		
			
			CHECK((_spawnpos select 0)==0)
			_spawnpos = ASLtoATL _spawnpos;
			_spawndir = _current_dir + (_spawnposarray select 3);
			_spawnpos = [_spawnpos, 0.35, (_spawndir + 90)] call BIS_fnc_relPos;
			_spawnpos pushBack _spawndir;
			_mines_spawnarray pushBack _spawnpos;
			DEC(_mines_count);
		};
	};
};

If (!(_mines_spawnarray isEqualTo [])) then {
	[_mines_spawnarray,2] call FM(city_spawn_explosives);
};























