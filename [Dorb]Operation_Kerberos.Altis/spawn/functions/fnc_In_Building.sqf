/*
	Author: Dorbedo
	
	Description:
		
	
	Parameter(s):
		0 : ARRAY	- Gebäudearray
		1 : SCALAR	- Minumum
		2 : SCALAR	- Maximum
	
	Return
		ARRAY - Gebäudearray
*/
#include "script_component.hpp"
SCRIPT(in_building);
private ["_spawnpos","_spawnpos_del","_anz","_d","_gruppe","_position","_einheit","_unit"];
params[["_gebaeudearr",[],[[]]],["_min",5,[0]],["_max",10,[0]]];
LOG_3(_min,_max,_gebaeudearr);

if ((count _gebaeudearr) < 1 ) exitWith {
	ERROR(FORMAT_1("Spawn in BUILDING| Array hat keinen Inhalt \n %1",_gebaeudearr));
	_gebaeudearr
};

_spawnpos=[];
_spawnpos_del=[];


If (dorb_debug_log) then {
	private "_test1";
	_test1=0;
	{_test1=_test1 + (count _x)}foreach _gebaeudearr;
	LOG(FORMAT_1("Spawn in BUILDING| Count Gebaudepos=%1",_test1));
};

{
	_spawnpos = _spawnpos + _x;
}forEach _gebaeudearr;

if (count _spawnpos < 1) exitWith {
	ERROR(FORMAT_1("Spawn in BUILDING| No Spawnpos | %1",_gebaeudearr));
};

_anz = ((count _spawnpos)-1);
_anz = _anz min _max;
If (!(_anz<_min)) then {
	_anz = (floor(random (_anz - _min)) + _min);
};

LOG(FORMAT_1("Spawn in BUILDING| nacher anz=%1",_anz));


for "_i" from 0 to (_anz) do {
	if (count _spawnpos < 1) exitWith {
		LOG("Spawn in BUILDING| No more Spawnpos");
		_i=5000;
	};
	_d = floor(random count _spawnpos);
	_position = _spawnpos select _d;
	LOG_3(_d,_position,_spawnpos);
		
	_spawnpos set [_d,-1];
	_spawnpos = _spawnpos - [-1];
	_spawnpos_del pushBack _position;
	
	_gruppe = createGroup GVARMAIN(side);
	_einheit = dorb_menlist SELRND;
	sleep 0.2;
	LOG_4(GVARMAIN(side),_gruppe,_einheit,_position);
		
	_unit = [_position,_gruppe,_einheit] call FUNC(unit);
	
	_unit setPosatl _position;
	_unit setFormDir (random 360);

	if ((getposatl _unit select 2) > 8) then {
		_unit setUnitPos "MIDDLE";
	} else  {
		_unit setUnitPos "UP";
	};
	LOG_2(_unit,_position);

	
	if (dorb_debug) then {
		private "_mrkr";
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

LOG(FORMAT_1("Spawn in BUILDING| Return Gebaeudearr=%1",_gebaeudearr));

If (dorb_debug_log) then {
	private "_test2";
	_test2=0;
	{_test2=_test2 + (count _x);} forEach _gebaeudearr;
	LOG(FORMAT_1("Count Gebaudepos=%1",_test2));
};

_gebaeudearr



