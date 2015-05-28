 /*
	Author: Dorbedo

	Description:
	Does something

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)
	
	[this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
	
	
*/
#include "makros.hpp"
CHECK(!isServer)

private ["_radius","_position","_anzahl_inf","_anzahl_spec","_gruppe","_units","_rand"];
_position = _this select 0;
_suchradius = [_this, 1, 400,[0]] call BIS_fnc_Param;
_anzahl_inf = [_this, 2, 0,[0]] call BIS_fnc_Param;
_anzahl_spec = [_this, 3, 0,[0]] call BIS_fnc_Param;
_radius = [_this, 4, 1500,[0]] call BIS_fnc_Param;

d_log(FORMAT_4("INF ATTACK| Pos=%1 / Radius=%2 / Anzahl Inf=%3 / Anzahl Specops = %4 ",_position,_radius,_anzahl_inf,_anzahl_spec))

_units=[];
_rand=[];


for "_i" from 0 to _anzahl_inf do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,1] call dorb_fnc_random_pos;
	_spawnpos = _pos findEmptyPosition [1,40];
	_rand = dorb_grouplist_inf select floor random count dorb_grouplist_inf;
	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		d_log(FORMAT_3("Spawnpos=%1 / Gruppe=%2 / dorb_side=%3",_spawnpos,_rand,dorb_side))
		_return = [_spawnpos, dorb_side , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _position, _suchradius] call CBA_fnc_taskAttack;
		[_return] FCALL(moveToHC);
	};
};
d_log(FORMAT_1("Spawned Inf ATTACK | ",_units))

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
	_pos = [_position,_radius,1] call dorb_fnc_random_pos;
	_spawnpos = _pos findEmptyPosition [1,50,"O_UGV_01_rcws_F"];
	_rand = dorb_grouplist_sf select floor random count dorb_grouplist_sf;
	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		_return = [_spawnpos, dorb_side , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _position, _suchradius] call CBA_fnc_taskAttack;
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