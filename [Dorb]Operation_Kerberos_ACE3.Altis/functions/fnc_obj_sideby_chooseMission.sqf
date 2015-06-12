/*
	Author: iJesuz
	
	Description:
		Nebenmission gemäß der Hauptmission spawnen

	Parameter(s):
		0 : Array - Hauptmission Position
		1 : String - Aufgabenname

*/
#include "script_component.hpp"

private ["_aufgabe", "_aufgaben", "_zeit", "_wichtung", "_position", "_positionen", "_locationName", "_location", "_task", "_side_task", "_task_array", "_basisPosition"];

_locationName = _this select 0;
_location = _this select 1;
_task = _this select 2;
_side_task = FORMAT_1("%1_side", _task);

// Missionsstart zwischen 20min (1200 Sekunden) und 60min (3600 Sekunden) festlegen
_zeit = 1200 + (random 2401);
uiSleep _zeit;

_basisPosition = getMarkerPos "respawn_west";

_aufgaben = [ "ueberlaeufer", "sdv", "aircraft" ];
_wichtung = [ 1, 1, 1 ];
_aufgabe = [_aufgaben, _wichtung] call BIS_fnc_selectRandomWeighted;

if (_aufgabe == "sdv") then {
	_positionen = GETMVAR(DORB_WASSER,[]);	// ["Name",[x,y]]
} else {
	_positionen = GETMVAR(DORB_SONSTIGES,[]);	// ["Name",[x,y]]
};
_position = (_positionen SELRND) select 1;

_counter = 0;
while { ((_position distance _location) < 6000) AND ((_position distance _basisPosition) < 6000)  } do {
	_position = _positionen SELRND;
	_counter = _counter + 1;
	if (_counter > 100) exitWith {};
};

_task_array = [_side_task,_task];

switch (_aufgabe) do
{
	case "ueberlaeufer":
	{
		[_position + [0], _task_array] call FM(TRIPLES(obj,sideby,ueberlaeufer));
	};
	case "sdv":
	{
		[_position + [0], _task_array] call FM(TRIPLES(obj,sideby,sdv));
	};
	case "aircraft":
	{
		[_position + [0], _task_array] call FM(TRIPLES(obj,sideby,aircraft));
	};
};
