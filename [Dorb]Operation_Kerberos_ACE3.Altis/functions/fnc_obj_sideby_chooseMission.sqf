/*
	Author: iJesuz,Dorbedo
	
	Description:
		Nebenmission gemäß der Hauptmission spawnen

	Parameter(s):
		0 : STRING - Ort
		1 : Array - Hauptmission Position
		2 : STRING - Aufgabe
		3 : STRING - Name of last Sidemission
	
	Example:
		["Kavalla",[500,500],"Task1"] call FM(obj_sideby_chooseMission);
	

*/
#include "script_component.hpp"

private ["_aufgabe", "_aufgaben", "_zeit", "_wichtung", "_position", "_positionen", "_side_task", "_task_array", "_basisPosition","_namearr","_sidetasknumber","_state","_basisPosition","_temp"];
PARAMS_3(_locationName,_location,_task);

//// generates the sidmissionnumber
If ((count _this)>3) then {

	_namearr = [(_this select 3),"_"] call BIS_fnc_splitString;
	_sidetasknumber = parsenumber (_namearr select ((count _namearr) -1));
	
	if (_sidetasknumber<1) then {
		_sidetasknumber=(floor(random 1000))+100;
	}else{
		INC(_sidetasknumber);
	};
	
	_side_task = FORMAT_2("%1_side_%2", _task,_sidetasknumber);
	
}else{
	_side_task = FORMAT_1("%1_side_1", _task);
};


// Missionsstart zwischen 20min (1200 Sekunden) und 60min (3600 Sekunden) festlegen
//_zeit = 1200 + (random 2401);
_zeit=15;
uiSleep _zeit;

// Exit if Mainmission is already finished
_state = [_task] call BIS_fnc_taskState;
If (_state in ["CANCELED","SUCCEEDED","FAILED"]) exitWith {};


_aufgaben = [ "ueberlaeufer", "sdv", "aircraft" ];
_wichtung = [ 1, 1, 1 ];


_aufgabe = [_aufgaben, _wichtung] call BIS_fnc_selectRandomWeighted;
_basisPosition = getMarkerPos "respawn_west";

if (_aufgabe == "sdv") then {
	_positionen = GETMVAR(DORB_WASSER,[]);	// ["Name",[x,y]]
} else {
	_positionen = (GETMVAR(DORB_SONSTIGES,[])) + (GETMVAR(DORB_INDUSTRIE,[]));	// ["Name",[x,y]]
};

_position=[];
_temp=[];

for "_i" from 0 to 120 do {
	_temp = (_positionen SELRND) select 1;
	If ( ((_temp distance _location) > 6000) AND ((_temp distance _basisPosition) > 6000) ) exitWith {_position=_temp;};
};

CHECK(_position isEqualTo [])

_task_array = [_side_task,_task];

switch (_aufgabe) do {
	case "ueberlaeufer" : {
		[_position + [0], _task_array, _locationName] call FM(TRIPLES(obj,sideby,ueberlaeufer));
	};
	case "sdv": {
		[_position + [0], _task_array, _locationName] call FM(TRIPLES(obj,sideby,sdv));
	};
	case "aircraft" : {
		[_position + [0], _task_array, _locationName] call FM(TRIPLES(obj,sideby,aircraft));
	};
};

/// Check if Mainmission is already finished - if not-> call another sidemission
_state = [_task] call BIS_fnc_taskState;
If (!(_state in ["CANCELED","SUCCEEDED","FAILED"])) then {
	[_locationName,_location,_task,_side_task] call FM(obj_sideby_chooseMission);
};