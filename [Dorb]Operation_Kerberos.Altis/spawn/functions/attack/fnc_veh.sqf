/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"
SCRIPT(veh);
CHECK(!isServer)

private ["_gruppe","_units","_rand"];
params["_position",["_suchradius",400,[0]],["_anzahl_leicht",0,[0]],["_anzahl_schwer",0,[0]],["_radius",1500,[0]]];
LOG_5(_position,_suchradius,_anzahl_leicht,_anzahl_schwer,_radius);

_vehicles=[];
_rand=[];
_einheit="";
for "_i" from 0 to (_anzahl_leicht) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,1] call EFUNC(common,random_pos);
	
	_rand = (floor(random 8));
	if (_rand < 2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_unarmored SELRND;
	};
	sleep 3;
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];
		
	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition \ %1 ",_spawnpos));
	}else{
		LOG_3(_spawnpos,_einheit,dorb_side);
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), _position, _suchradius] call CBA_fnc_taskAttack;
	};
};

for "_i" from 0 to (_anzahl_leicht) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,1] call EFUNC(common,random_pos);
	
	_rand = (floor(random 8));
	if (_rand<2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_armored SELRND;
	};
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];
	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition \ %1 ",_spawnpos));
	}else{
		LOG_3(_spawnpos,_einheit,dorb_side);
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), _position, _suchradius] call CBA_fnc_taskAttack;
	};
};

LOG(FORMAT_1("Spawned Vehicles \n %1 ",_vehicles));


if (dorb_debug) then {
	{
		_mrkr = createMarker [format["veh-%1",_x],getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_mech_inf";
		
	}forEach _vehicles;
};