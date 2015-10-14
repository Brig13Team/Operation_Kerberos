/*
	Author: Dorbedo

	Description:
	Spawns Inf Patrols

	Parameter(s):
		0 :	ARRAY	- Position
		(Optional)
		1 : NUMBER 	- Radius
		2 : NUMBER 	- Anzahl Inf Patrols
		3 : NUMBER 	- Anzahl Spec Patrols
		

	Returns:
		Nothing

*/
#include "script_component.hpp"
SCRIPT(inf);
private ["_gruppe","_units"];
params["_position",["_radius",1200,[0]],["_anzahl_inf",0,[0]],["_anzahl_spec",0,[0]]];

_units=[];
_rand=[];

for "_i" from 0 to _anzahl_inf do {
	private["_formation","_rad","_pos","_spawnpos","_rand","_return"];
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call EFUNC(common,random_pos);
	_spawnpos = _pos findEmptyPosition [1,40];
	_rand = dorb_grouplist_inf SELRND;

	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
	}else{
		_return = [_spawnpos, GVARMAIN(side) , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		_formation = ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"] SELRND;
		[_return, _spawnpos, _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", _formation, "", [5,10,15]] call EFUNC(spawn,taskPatrol);
		
	};
};
LOG(FORMAT_1("Spawned Inf Patrols | %1",_units));


if (dorb_debug) then {
	private "_mrkr";
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _units;
};

_units=[];

for "_i" from 0 to _anzahl_spec do {
	private["_formation","_rad","_pos","_spawnpos","_rand","_return"];
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call EFUNC(common,random_pos);
	_spawnpos = _pos findEmptyPosition [1,50,"O_UGV_01_rcws_F"];
	_rand = dorb_grouplist_sf SELRND;

	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
	}else{
		_return = [_spawnpos, GVARMAIN(side) , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		_formation = ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"] SELRND;
		[_return, _spawnpos, _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", _formation, "", [5,10,15]] call EFUNC(spawn,taskPatrol);
		
	};
};
LOG(FORMAT_1("Spawned Specops Patrols | %1",_units));


if (dorb_debug) then {
	private "_mrkr";
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _units;
};