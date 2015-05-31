/*
	Author: Dorbedo

	Description:
	Does something

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)
*/
#include "script_component.hpp"
private ["_gebaeudearr","_min","_max","_spawnpos_arr","_anz","_d","_gruppe","_position","_einheit","_unit"];

_gebaeudepos_arr = _this select 0;
_min = _this select 1;
_max = _this select 2;
_wpnrad = 1.5;
_spawnpos_arr = [];
_spawnpos_arr_del = [];

d_log(FORMAT_2("Spawn ROOFTOP| min=%1,max=%2",_min,_max))
d_log(FORMAT_1("Spawn ROOFTOP| _gebaeudepos_arr=%1",_gebaeudepos_arr))

if ((count _gebaeudepos_arr)>0) then {
	for "_i" from 0 to (count _gebaeudepos_arr) do {
		_temppos = [];
	
		{
			_buildPosASL = ATLtoASL(_x);
			
			_isObstructedZ = lineIntersects [_buildPosASL, [(_buildPosASL select 0), (_buildPosASL select 1), (_buildPosASL select 2) + 20]];
			_hasSurfaceBelowXa = lineIntersects [[(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
			_hasSurfaceBelowXb = lineIntersects [[(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
			_hasSurfaceBelowYa = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2) - 0.5]];
			_hasSurfaceBelowYb = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2) - 0.5]];
			
			if (! _isObstructedZ and (_hasSurfaceBelowXa and _hasSurfaceBelowXb) and (_hasSurfaceBelowYa and _hasSurfaceBelowYb)) then {
			
				_temppos pushBack _x;
				
			};
		} foreach (_gebaeudepos_arr select _i);
		
		if ((count _temppos) > 0) then {
			_Rooftopsel = _temppos SELRND;
			_spawnpos_arr pushBack _Rooftopsel;
		};
	};
};
d_log(FORMAT_1("Spawn ROOFTOP| spawnpos=%1",_spawnpos_arr))

_anz = ((count _spawnpos_arr)-1);
_anz = _anz min _max;
If (!(_anz<_min)) then {
	_anz = (floor(random (_anz - _min)) + _min);
};

d_log(FORMAT_1("Spawn ROOFTOP| nacher anz=%1",_anz))

for "_i" from 0 to (_anz) do {
	_d = floor(random count _spawnpos_arr);
	
	_spawnposition = _spawnpos_arr select _d;
	_spawnpos_arr set [_d,-1];
	
	_spawnpos_arr = _spawnpos_arr - [-1];
	_spawnpos_arr_del = _spawnpos_arr_del + [_spawnposition];
	
	_gruppe = createGroup dorb_side;
	_einheit = dorb_staticlist SELRND;
	
	d_log(FORMAT_2("Create ROOFTOP | einheit=%1 | _spawnpos=%2",_einheit,_spawnposition))

	_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
	[_unit,_gruppe] call BIS_fnc_spawnCrew;
	[_gruppe] FCALL(moveToHC);
	
	if (dorb_debug) then {
		_mrkr = createMarker [format ["%1-%2s",name _unit,_i],getPos _unit];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorOrange";
		_mrkr setMarkerType "hd_dot";	
	};
};

d_log(FORMAT_1("ROOFTOP| Spawnpos=%1",_spawnpos_arr_del))

{
	for "_i" from 0 to ((count _x)-1) do {
		if ((_x select _i) in _spawnpos_arr_del) exitWith {
			_x = _x deleteAt _i;
		};
	};
	if ((count _x)<1) then {_x = [-1];};
}forEach _gebaeudepos_arr;
_gebaeudepos_arr = _gebaeudepos_arr - [-1];

d_log(FORMAT_1("ROOFTOP| ARR_RETURN=%1",_gebaeudepos_arr))

_gebaeudepos_arr