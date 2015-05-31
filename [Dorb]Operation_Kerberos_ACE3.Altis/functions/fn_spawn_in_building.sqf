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

private ["_gebaeudearr","_min","_max","_spawnpos","_anz","_d","_gruppe","_position","_einheit","_unit"];

d_log("Spawn in BUILDING|")
_gebaeudearr = [_this, 0, [],[[]]] call BIS_fnc_Param;
_min = [_this, 1, 5,[0]] call BIS_fnc_Param;
_max = [_this, 2, 10,[0]] call BIS_fnc_Param;
d_log(FORMAT_1("Spawn in BUILDING| gebaeudearr=%1",_gebaeudearr))
d_log(FORMAT_2("Spawn in BUILDING| min %1 | max %2",_min,_max))

if ((count _gebaeudearr) < 1 ) exitWith {
	d_error_p(FORMAT_1("Spawn in BUILDING| Array hat keinen Inhalt | %1",_gebaeudearr))
	_gebaeudearr
};

_spawnpos=[];
_spawnpos_del=[];


If (dorb_debug_log) then {
	_test1=0;
	{_test1=_test1 + (count _x)}foreach _gebaeudearr;
	d_log(FORMAT_1("Spawn in BUILDING| Count Gebaudepos=%1",_test1))
};

{
	_spawnpos = _spawnpos + _x;
}forEach _gebaeudearr;

if (count _spawnpos < 1) exitWith {
	d_error_p(FORMAT_1("Spawn in BUILDING| No Spawnpos | %1",_gebaeudearr))
};

_anz = ((count _spawnpos)-1);
_anz = _anz min _max;
If (!(_anz<_min)) then {
	_anz = (floor(random (_anz - _min)) + _min);
};

d_log(FORMAT_1("Spawn in BUILDING| nacher anz=%1",_anz))


for "_i" from 0 to (_anz) do {
	if (count _spawnpos < 1) exitWith {
		d_log("Spawn in BUILDING| No more Spawnpos")
		_i=5000;
	};
	_d = floor(random count _spawnpos);
	_position = _spawnpos select _d;
	
	d_log(FORMAT_2("d=%1 | POS: %2",_d,_position))
	d_log(FORMAT_1("_spawnpos=%1",_spawnpos))
	
	_spawnpos set [_d,-1];
	_spawnpos = _spawnpos - [-1];
	_spawnpos_del pushBack _position;
	
	_gruppe = createGroup dorb_side;
	_einheit = dorb_menlist SELRND;
	sleep 0.2;
	d_log(FORMAT_4("Call spawnUnit: SIDE=%1 // Gruppe=%2 // Einheit=%3 // Pos= %4",dorb_side,_gruppe,_einheit,_position))
	
	_unit = [_position,_gruppe,_einheit] call dorb_fnc_spawn_unit;
	
	_unit setPosatl _position;
	_unit setFormDir (random 360);

	if ((getposatl _unit select 2) > 8) then {
		_unit setUnitPos "MIDDLE";
	} else  {
		_unit setUnitPos "UP";
	};
	
	d_log(FORMAT_2("UNIT; %1 | POS: %2",_unit,_position))
	
	if (dorb_debug) then {
		_mrkr = createMarker [format ["%1-%2",name _unit,_i],getPos _unit];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorGreen";
		_mrkr setMarkerType "hd_dot";	
	};
};

{
	for "_i" from 0 to ((count _x)-1) do {
		if ((_x select _i) in _spawnpos_del) exitWith {
			_x = _x deleteAt _i;
		};
	};
	if ((count _x)<1) then {_x = [-1];};
}forEach _gebaeudearr;
_gebaeudearr = _gebaeudearr - [-1];

d_log(FORMAT_1("Spawn in BUILDING| Return Gebaeudearr=%1",_gebaeudearr))

If (dorb_debug_log) then {
	_test2=0;
	{_test2=_test2 + (count _x);} forEach _gebaeudearr;
	d_log(FORMAT_1("Count Gebaudepos=%1",_test2))
};

_gebaeudearr



