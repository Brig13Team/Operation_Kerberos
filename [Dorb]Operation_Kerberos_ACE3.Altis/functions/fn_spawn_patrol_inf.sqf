/*
	Author: Dorbedo

	Description:
	Spawns Inf Patrols

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)

*/
#include "script_component.hpp"

private ["_radius","_position","_anzahl_inf","_anzahl_spec","_gruppe","_units","_rand"];
_position = _this select 0;
_radius = [_this, 1, 1200,[0]] call BIS_fnc_Param;
_anzahl_inf = [_this, 2, 0,[0]] call BIS_fnc_Param;
_anzahl_spec = [_this, 3, 0,[0]] call BIS_fnc_Param;

d_log(FORMAT_4("INF PATROL| Pos=%1 / Radius=%2 / Anzahl Inf=%3 / Anzahl Specops = %4 ",_position,_radius,_anzahl_inf,_anzahl_spec))

_units=[];
_rand=[];


for "_i" from 0 to _anzahl_inf do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] FCALL(random_pos);
	_spawnpos = _pos findEmptyPosition [1,40];
	_rand = dorb_grouplist_inf SELRND;

	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		_return = [_spawnpos, dorb_side , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _spawnpos, _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[_return] FCALL(moveToHC);
	};
};
d_log(FORMAT_1("Spawned Inf Patrols | ",_units))


if (dorb_debug) then {
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _units;
};

_units=[];

for "_i" from 0 to _anzahl_spec do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] FCALL(random_pos);
	_spawnpos = _pos findEmptyPosition [1,50,"O_UGV_01_rcws_F"];
	_rand = dorb_grouplist_sf SELRND;

	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		_return = [_spawnpos, dorb_side , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _spawnpos, _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[_return] FCALL(moveToHC);
	};
};
d_log(FORMAT_1("Spawned Specops Patrols | ",_units))


if (dorb_debug) then {
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _units;
};