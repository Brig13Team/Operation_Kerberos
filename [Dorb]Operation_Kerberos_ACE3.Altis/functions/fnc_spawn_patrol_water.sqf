/*
	Author: Dorbedo

	Description:
	Spawns Water Patrols

	Parameter(s):
		0 :	ARRAY	- Spawnposition
		1 : SCALAR 	- Radius
		2 : SCALAR	- number of boats (-1 = automatic)
		3 : SCALAR	- nuber of divers (-1 = automatic)
		

	Returns:
	

	
*/
#include "script_component.hpp"

private ["_gruppe","_units","_vehicles","_rad","_pos","_spawnpos","_einheit","_return"];
PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,1200);
DEFAULT_PARAM(2,_anzahl_boats,0);
DEFAULT_PARAM(3,_anzahl_diver,0);
_amountOfWater = 0;
//If  ((_anzahl_boats<0)||(_anzahl_diver<0)) then {
	_searchposarray = [_position];
	_searchrad = 1;
	_step = 50;
	_s = 0;
	while {_searchrad < _radius} do {
		_umfang = 2 * pi * _searchrad;
		_theta = ((_s*360)/(2*_searchrad*pi));
		_searchposarray pushBack ([_position, _searchrad, _theta] call BIS_fnc_relPos);
		_s=_s+_step;
		If (_s > _umfang) then {
			_searchrad = _searchrad + _step;
			_s=0;
		};
	};
	
	_amountOfWater = {
			/*
			If (surfaceIsWater _x) then {
				_mrkr = createMarker [format["infp-%1",random(999999)],_x];
				_mrkr setMarkerShape "ICON";
				_mrkr setMarkerColor "ColorBlue";
				_mrkr setMarkerType "o_inf";
			}else{
				_mrkr = createMarker [format["infp-%1",random(999999)],_x];
				_mrkr setMarkerShape "ICON";
				_mrkr setMarkerColor "ColorRed";
				_mrkr setMarkerType "o_inf";
			};
			*/
		surfaceIsWater _x
		}count _searchposarray;
//};
/// exit if there is only a small amount of water
CHECK(_amountOfWater<301)

If (_anzahl_boats < 0) then {
	_anzahl_boats = floor((_amountOfWater - 300)/200);
};
If (_anzahl_diver < 0) then {
	_anzahl_diver = floor((_amountOfWater - 300)/350);
};

LOG_2(_anzahl_boats,_anzahl_diver);


_patrol = {
	Private["_wp_behavior","_wp_competionradius","_wp_formation","_wp_speed","_wp_type"];
	_wp_behavior = "RED";
	_wp_competionradius = 40;
	_wp_formation = "STAG COLUMN";
	_wp_speed = "LIMITED";
	_wp_type = "MOVE";

	private ["_prevPos"];
	PARAMS_3(_grp,_pos,_maxDist);
	DEFAULT_PARAM(3,_depth,0);
	_grp setBehaviour _wp_behavior;
	
	_prevPos = _pos;
	for "_i" from 0 to (2 + (floor (random 3))) do
	{
		private ["_wp", "_newPos"];
		//_newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
		_newPos = [_prevPos,_maxDist,3] call FM(random_pos);
		
		_bestpos = (selectBestPlaces [_newPos, 15, "waterdepth", 2, 5]);
		_newPos = (_bestpos select 0) select 0;
		_newPos set [2,_depth];
		
		
		if (dorb_debug) then {
			_mrkr = createMarker [format["veh-%1-%2",_i,_newPos],_newPos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorBlue";
			_mrkr setMarkerType "hd_dot";
		};
		
		
		
		//_newPos = _newPos isFlatEmpty [7.5,10,0.7,14,2,true];
		
		_prevPos = _newPos;

		_wp = _grp addWaypoint [_newPos, 0];
		_wp setWaypointType _wp_type;
		_wp setWaypointCompletionRadius _wp_competionradius;

		if (_i == 0) then
		{
			_wp setWaypointSpeed _wp_speed;
			_wp setWaypointFormation _wp_formation;
		};
	};
	
	private ["_wp"];
	_wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 20;

	true

};

_vehicles=[];

for "_i" from 0 to _anzahl_boats do {
	_rad = ((random 200) + 500);
	_spawnpos = [_position,_radius,3] call FM(random_pos);
	_einheit = dorb_patrolboatlist SELRND;
	If (!(_spawnpos isEqualTo [])) then {
		_bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
		CHECK(_bestpos isEqualTo [])
		_spawnpos = (_bestpos select 0) select 0;
		if (dorb_debug) then {
			_mrkr = createMarker [format["naval-%1",_spawnpos],_spawnpos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorRed";
			_mrkr setMarkerType "n_naval";
		};
		_spawnpos set[2,0];
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), _spawnpos, _rad] spawn _patrol;
		[(_return select 2)] call FM(moveToHC);	
	};
};
LOG("diver");
for "_i" from 0 to _anzahl_diver do {
	_rad = ((random 200) + 100);
	_spawnpos = [_position,_radius,3] call FM(random_pos);
	LOG_1(_spawnpos);
	If (!(_spawnpos isEqualTo [])) then {
		_einheiten = [];
		for "_j" from 0 to 3 do {
			_einheiten pushBack (dorb_diverlist SELRND)
		};
		_bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
		LOG_1(_bestpos);
		CHECK(_bestpos isEqualTo [])
		_spawnpos = (_bestpos select 0) select 0;
		_spawnpos set[2,0];
		LOG_1(_spawnpos);
		if (dorb_debug) then {
			_mrkr = createMarker [format["navald-%1",_spawnpos],_spawnpos];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorRed";
			_mrkr setMarkerType "n_inf";
		};
		_return = [_spawnpos,dorb_side,_einheiten] call BIS_fnc_spawnGroup;
		_vehicles pushBack (units _return);		
		[_return, _spawnpos, _rad,-10] spawn _patrol;
		{_x swimInDepth -10} forEach (units _return);
		[_return] call FM(moveToHC);
	};
};





