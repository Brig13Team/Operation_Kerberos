 /*
	Author: Dorbedo

	Description:
	Does something

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)
	
	[this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call EFUNC(spawn,taskPatrol);
	
	
*/
#include "script_component.hpp"
SCRIPT(inf);
CHECK(!isServer)

private ["_gruppe","_units","_rand"];
params["_position",["_suchradius",400,[0]],["_anzahl_inf",0,[0]],["_anzahl_spec",0,[0]],["_radius",1500,[0]]];
LOG_5(_position,_suchradius,_anzahl_inf,_anzahl_spec,_radius);

_units=[];
_rand=[];


for "_i" from 0 to _anzahl_inf do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,1] call EFUNC(common,pos_random);
	_spawnpos = _pos findEmptyPosition [1,40];
	_rand = dorb_grouplist_inf SELRND;
	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
	}else{
		
		LOG_3(_spawnpos,_rand,GVARMAIN(side));
		_return = [_spawnpos, GVARMAIN(side) , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _position, _suchradius] call CBA_fnc_taskAttack;
	};
};
LOG(FORMAT_1("Spawned Inf ATTACK \n %1 ",_units));

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
	_pos = [_position,_radius,1] call EFUNC(common,pos_random);
	_spawnpos = _pos findEmptyPosition [1,50,"O_UGV_01_rcws_F"];
	_rand = dorb_grouplist_sf SELRND;
	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | ",_spawnpos));
	}else{
		_return = [_spawnpos, GVARMAIN(side) , _rand] call BIS_fnc_spawnGroup;
		_units pushBack _return;
		[_return, _position, _suchradius] call CBA_fnc_taskAttack;
	};
};
LOG(FORMAT_1("Spawned Specops Patrols \n %1 ",_units));

if (dorb_debug) then {
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _units;
};