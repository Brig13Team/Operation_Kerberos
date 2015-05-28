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
#include "makros.hpp"

private ["_gebauede","_rad","_pos","_i","_fertig","_gebauedepos","_temp"];
_pos = _this select 0;
CHECK((count _pos)<2)
_rad = [_this,1,250,[0]] call BIS_fnc_param;
_gebauede = [];
_gebauedepos = [];

d_log(FORMAT_2("Erstelle Gebäudearray / Pos=%1 / Rad=%2",_pos,_rad))
_gebauede = _pos nearObjects ["HouseBase", _rad];
_anz = ((count _gebauede)-1) min 150;
d_log(FORMAT_1("Anzahl der Gebäude=%1",_anz))
for "_j" from 0 to _anz do {
	_i=0;
	_fertig=false;
	_temp=[];
	while {!_fertig} do {
		_geb_pos=(_gebauede select _j) buildingPos _i;
		if ((str _geb_pos == "[0,0,0]") or (((_gebauede select _j) isKindOf "Piers_base_F")) or (isNil "_geb_pos")) then {
			_fertig=true;
		}else{
			PUSH(_temp,_geb_pos);
		};
		INC(_i);
	};
	if ((count _temp > 0)and !(isNil "_temp")) then {
		PUSH(_gebauedepos,_temp);
	};
};
d_log(FORMAT_1("Gebäudearray=%1",_gebauedepos))
_gebauedepos