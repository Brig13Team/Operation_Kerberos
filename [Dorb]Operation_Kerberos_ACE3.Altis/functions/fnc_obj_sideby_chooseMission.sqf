/*
	Author: iJesuz
	
	Description:
		Nebenmission gemäß der Hauptmission spawnen

	Parameter(s):
		0 : Array - Hauptmission Position
		1 : String - Aufgabenname

*/
#include "script_component.hpp"

private ["_aufgabe", "_aufgaben", "_zeit", "_wichtung", "_position", "_positionen", "_hauptaufgabePosition", "_hauptaufgabeName", "_basisPosition"];

_hauptaufgabePosition = _this select 0;
_hauptaufgabeName = _this select 1;

_task = nil;

_keinUeberlaeufer = ["destroy_tower", "destroy_device", "capture_prototype", "Scarab", "area_clear", "area_defend"];
if (!(_hauptaufgabeName in _keinUeberlaeufer)) then {
	// Missionsstart zwischen 20min (1200 Sekunden) und 60min (3600 Sekunden) festlegen
	_zeit = 1200 + (random 2401);
	uiSleep _zeit;

	_basisPosition = getMarkerPos "respawn_west";

	_aufgaben = [ "ueberlaeufer", "sdv" ];
	_wichtung = [ 1, 1 ];
	_aufgabe = [_aufgaben, _wichtung] call BIS_fnc_selectRandomWeighted;

	if (_aufgabe == "sdv") then {
		_positionen = GETMVAR(DORB_WASSER,[]);	// ["Name",[x,y]]
	} else {
		_positionen = GETMVAR(DORB_SONSTIGES,[]);	// ["Name",[x,y]]
	};
	_position = (_positionen SELRND) select 1;

	while { ((_position distance _posMainMission) < 6000) AND ((_position distance _basisPosition) < 6000)  } do { _position = _positionen SELRND; };

	switch (_aufgabe) do
	{
		case "ueberlaeufer":
		{
			[_position + [0], _task] call FM(TRIPLES(obj,sideby,ueberlaeufer));
		};
		case "sdv":
		{
			[_position + [0], _task] call FM(TRIPLES(obj,sideby,sdv));
		};
		case "aircraft":
		{
			[_position + [0], _task] call FM(TRIPLES(obj,sideby,aircraft));
		};
	};
};
