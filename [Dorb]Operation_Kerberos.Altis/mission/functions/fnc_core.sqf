/*
	Author: Dorbedo
	
	Description:
		Core function
	
*/
#include "script_component.hpp"
SCRIPT(core);
CHECK(!isServer)

GVARMAIN(debug)=false;

private ["_aufgabennummer","_aktuelle_aufgabe","_return"];
_aufgabennummer=0;
_return = [] call EFUNC(common,get_cfglocations);
SETMVAR(GVAR(stadt),(_return select 0));
SETMVAR(GVAR(industrie),(_return select 1));
SETMVAR(GVAR(militaer),(_return select 2));
SETMVAR(GVAR(wasser),(_return select 3));
SETMVAR(GVAR(sonstiges),(_return select 4));

// Delete dead Units
[{
	If ((count allDead)>20) then {
		private["_allDead","_anzahl"];
		_allDead = allDead;
		_anzahl = floor(((count allDead)/3)*2);
		_allDead resize _anzahl;
		{_x TILGE;}forEach _allDead;
	};
} , 180, [] ] call CBA_fnc_addPerFrameHandler;

/// Cleanup script (small version)
[{[] spawn EFUNC(common,cleanup_small);} , 900, [] ] call CBA_fnc_addPerFrameHandler;


/// Rescue Point;
private["_markerpos"];
_markerpos = getMarkerPos "rescue_marker";
If ((_markerpos distance [0,0,0])>1) then {
	[{
		private "_units";
		_units = (getMarkerPos "rescue_marker") nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 15];
			{
				[_x,QGVAR(rescuepoint),[_x]] call BIS_fnc_callScriptedEventHandler;
			}forEach _units;
	} , 30, [] ] call CBA_fnc_addPerFrameHandler;
};


/// Diag
/*
[] spawn {
	SCRIPTIN(core,performance);
	while {true} do {
	For "_i" from 0 to 4 do {
		[false,false] call EFUNC(main,debug_performance);
		uisleep 60;
	};
	[true,false] call EFUNC(main,debug_performance);
	uisleep 60;
	false
	};

};
*/
uisleep 20;

for "_u" from 0 to 120 do {
	uisleep 5;
	INC(_aufgabennummer);
	_aktuelle_aufgabe = FORMAT_1("task_%1",_aufgabennummer);
	TRACEV_2(_aufgabennummer,_aktuelle_aufgabe);
	[_aktuelle_aufgabe] call FUNC(choose);
};
ERROR("CORE LOOP CRASHED");
endMission "End1";
