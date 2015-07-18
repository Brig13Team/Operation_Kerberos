/*
	Author: Dorbedo
	
	Description:
		
		- Weights the Roads, select  important Roadpositions,
		- sends Veh-Patrols,Inf-Patrols
		
	
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
	for "_i" from 0 to (floor((count _garages)/3)) do {
		_einheit = dorb_civ_cars SELRND;
		_spawnpos = ASLtoATL ((_garages select _i) select 1);
		_spawndir = (_garages select _i) select 2;
		_newpos = _spawnpos;
		_spawnpos set[2,((_spawnpos select 2)+2000)];
		_newpos set[2,((_newpos select 2)+0.5)];
		_veh = createVehicle [_einheit,_spawnpos, [], 0, "CAN_COLLIDE"];
		_veh setDir _spawndir;
		_veh setPosATL _newpos;
		If (dorb_debug) then {
			_mrkr = createMarker [format["CivVehiclesGarage-%1",_newpos],_newpos];
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
_mines_count = 0;
If (_mines) then {
	_mines_count = (floor((count(_buildings))/2) min 30);
};

_lastpos = 0;
/// statics and units
for "_i" from 0 to ((count _buildings)-1) do {
	_current_type = (_buildings select _i) select 0;
	_current_posASL = (_buildings select _i) select 1;
	_current_dir = (_buildings select _i) select 2;
	_buildingpos = [];
	_buildingpos = getArray(missionConfigFile >> "city_defence" >> "buildings_vanilla" >> "soldierpos");
	_staticpos = [];
	_unitpos = [];
	If (!(_buildingpos isEqualTo [])) then {
		// look for static-positions
		{
			If (((_x select 5)==1)||(_x select 5)==3) then {
				_staticpos pushBack _x;
			}else{
				_unitpos pushBack _x;
			};
		}forEach _buildingpos;
		_spawnamount = 0;
		If ((count _staticpos)>5) then {
			_spawnamount = 2;
		}else{
			If (!(_staticpos isEqualTo [])) then {
				_spawnamount = 1;
			};
		};
		
		for "_j" from 0 to _spawnamount do {
			_staticpos = _staticpos call BIS_fnc_arrayShuffle;
			_spawnposarray = _staticpos call BIS_fnc_arrayShift
			
			If ((_spawnposarray select 5)<2) then {
				_unit = dorb_staticlist_high SELRND;
			}else{
				_unit = dorb_staticlist SELRND;
			};
			
			_spawnpos = [		(_spawnposarray select 0)+(_current_posASL select 0),
							(_spawnposarray select 1)+(_current_posASL select 1),
							(_spawnposarray select 2)+(_current_posASL select 2)
						];
			If ((_spawnposarray select 4)>=0) then {
				_spawndir = _current_dir + (_spawnposarray select 3);
			}else{
				_spawndir = _current_dir + ((((_spawnposarray select 4)-(_spawnposarray select 3))/2))+(_spawnposarray select 3));
			};
			
			_veh = createVehicle [_unit, _spawnpos, [], 0, "CAN_COLLIDE"];
			_gruppe = createGroup dorb_side;
			[_veh,_gruppe] call FM(spawn_crew);
			
		};
		
		
	
	};
	_lastpos = _i;
};

/// mines


























