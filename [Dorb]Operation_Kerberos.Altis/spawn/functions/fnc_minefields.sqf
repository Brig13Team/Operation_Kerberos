/*
	Author: Dorbedo
	
	Description:
		Spawns Minefields at random locatuions
	
	Parameter(s):
		0 : ARRAY	- Position
		1 : SCALAR	- Spawnradius
		2 : SCALAR	- Count
	
	Return
	BOOL
*/
#include "script_component.hpp"
SCRIPT(minefields);
params[["_position",[],[[]],[2,3]],["_radius",1300,[0]],["_anzahl",8,[0]]];

CHECKRET((_position isEqualTo []),false);


_spawnpos = [];
_temp = [];
_forests = [];
_forests = selectBestPlaces [_position, _radius, "forest+(trees*0.5)", 20, 30];
_flatLand = selectBestPlaces [_position, _radius, "meadow + (trees*0.2)", 20, 60];

{
	If ((_x select 1)>0.5) then {
		_temp = [[((_x select 0)select 0),((_x select 0)select 1),0],30,2,15];
		_spawnpos pushBack _temp;
	};
}forEach _forests;

{
	If ((_x select 1)>0.5) then {
		_temp = [[((_x select 0)select 0),((_x select 0)select 1),0],30,0,20];
		_spawnpos pushBack _temp;
	};
}forEach _flatLand;

_spawnpos call BIS_fnc_arrayShuffle;

_spawnanzahl = (count _spawnpos) min _anzahl;

for "_i" from 0 to _spawnanzahl do {
	(_spawnpos select _i) call FUNC(minefield);
	If (dorb_debug) then {
		_mrkr = createMarker [format["minepos-%1",((_spawnpos select _i) select 0)],((_spawnpos select _i) select 0)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlue";
		If (((_spawnpos select _i) select 2)>0) then {
			_mrkr setMarkerType "MinefieldAP";
		}else{
			_mrkr setMarkerType "Minefield";
		};
	};
};

true;