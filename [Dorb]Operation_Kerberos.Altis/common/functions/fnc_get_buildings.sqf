/*
	Author: Dorbedo
	
	Description:
		Gebäude um Position auflisten
*/
#include "script_component.hpp"
SCRIPT(get_buildings);
_this params[["_pos",[],[[]]],["_rad",250,[0]]];
TRACEV_2(_pos,_rad);
CHECK(_pos isEqualTo [])
private ["_gebauede","_anz","_i","_fertig","_gebauedepos","_temp"];
_gebauede = [];
_gebauedepos = [];
_gebauede = _pos nearObjects ["HouseBase", _rad];
_anz = ((count _gebauede)-1) min 150;
for "_j" from 0 to _anz do {
	_i=0;
	_fertig=false;
	_temp=[];
	while {!_fertig} do {
		_geb_pos=(_gebauede select _j) buildingPos _i;
		if ((str _geb_pos == "[0,0,0]") or (((_gebauede select _j) isKindOf "Piers_base_F")) or (isNil "_geb_pos")) then {
			_fertig=true;
		}else{
			_temp pushBack _geb_pos;
		};
		INC(_i);
	};
	if ((count _temp > 0)and !(isNil "_temp")) then {
		_gebauedepos pushBack _temp;
	};
};
_gebauedepos;