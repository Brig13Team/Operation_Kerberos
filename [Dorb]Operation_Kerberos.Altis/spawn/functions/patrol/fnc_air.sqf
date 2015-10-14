/*
	Author: Dorbedo

	Description:
	Spawns Air Patrols

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)

	
*/
#include "script_component.hpp"
SCRIPT(air);
private ["_gruppe","_units","_vehicles","_rad","_pos","_spawnpos","_einheit","_return"];
params["_position",["_radius",1200,[0]],["_anzahl_heli",0,[0]],["_anzahl_plane",0,[0]]];

_vehicles=[];

for "_i" from 0 to _anzahl_heli do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call EFUNC(common,random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_attack_heli_list SELRND;
	LOG_3(_spawnpos,_einheit,GVARMAIN(side));
	_return = [_spawnpos,(random(360)),_einheit,GVARMAIN(side)] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call EFUNC(spawn,taskPatrol);
};

for "_i" from 0 to _anzahl_plane do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call EFUNC(common,random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_patrol_air_list SELRND;
	LOG_3(_spawnpos,_einheit,GVARMAIN(side));
	_return = [_spawnpos,(random(360)),_einheit,GVARMAIN(side)] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call EFUNC(spawn,taskPatrol);
};
LOG(FORMAT_1("Spawned Vehicles: \n %1 ",_vehicles));

if (dorb_debug) then {
	private "_mrkr";
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _vehicles;
};