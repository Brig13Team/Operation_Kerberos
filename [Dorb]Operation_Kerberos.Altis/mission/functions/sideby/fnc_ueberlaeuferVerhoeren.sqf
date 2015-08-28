/*
	Author: iJesuz
	
	Description:
		Eigenschaften implementieren und Informationen gemäß den Eigenschaften und Verhalten aufrufen.

	Parameter(s):
		0 : Object - Überläufer
		1 : String - Eigenschaft
		3 : Array - Taskarray
*/
#include "script_component.hpp"

SCRIPT(obj_sideby_ueberlaeuferVerhoeren);

private ["_ueberlaeufer", "_eigenschaft", "_task", "_main_task", "_info", "_suizidtimer", "_ueberlaeuferPosition", "_ziel", "_liste", "_counter", "_kontakt", "_durchmesser","_temp"];

_ueberlaeufer = _this select 0;
_eigenschaft = _this select 1;
_task = _this select 2 select 0;
_main_task = _this select 2 select 1;

_info = 100;
_ziel = getMarkerPos "rescue_marker";

_suizidtimer = 0;
_kontakt = 0;

_temp = missionNamespace getVariable [QGVAR(current_sidemission),""];

LOG("SCHLEIFE GESTARTET");
while { (!(_temp isEqualTo "")) AND {((((getPos _ueberlaeufer) distance _ziel) > 20) OR (captive _ueberlaeufer)) AND (alive _ueberlaeufer)} } do {
	uiSleep 5;

	switch (_eigenschaft) do
	{
		case "Flugangst":
		{
			if ( !isTouchingGround vehicle _ueberlaeufer ) then {
				_info = _info - 10;
			};
		};
		case "Paranoia":
		{
			_liste = _ueberlaeufer nearEntities ["Man", 50];
			_counter = 0;
			{
				if (side _x == west) then { _counter = _counter + 1; };
			} forEach _liste;
			if (_counter > 3) then {
				_info = _info - 10;
			};
		};
		case "suizidgefaehrdet":
		{
			_counter = 0;
			_liste = _ueberlaeufer nearEntities ["Man", 25];

			{
				if ((_kontakt == 0) AND (side _x == WEST)) then { _kontakt = 1; _counter = _counter + 1; };
				if ((_kontakt == 1) AND (side _x == WEST)) then { _counter = _counter + 1; };
			} forEach _liste;

			if ((_kontakt == 1) AND (_counter == 0)) then {
				_suizidtimer = _suizidtimer + 1;
			};
		};
		case "nichts": {};
	};

	_temp = missionNamespace getVariable [QGVAR(current_sidemission),""];

	if (_suizidtimer >= 2) exitWith {
		_info = 0;
		_ueberlaeufer setDamage 1;
	};
};
LOG("SCHLEIFE ABGEBROCHEN");
if (_temp isEqualTo "") exitWith {};

_info = _info / 100;

if ( (_info > 0) and (alive _ueberlaeufer) ) then {
	_durchmesser = 50;
	switch (_eigenschaft) do
	{
		case "Flugangst":
		{
			#ifndef TEST
				[_main_task, "targets", [2,_durchmesser * (2 - _info)]] call FUNC(reward);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser * (2 - _info)));
			#endif
		};
		case "Paranoia":
		{
			#ifndef TEST
				[_main_task, "useless_intel", [2, round (3 - (_info / 40)), _durchmesser, _durchmesser]] call FUNC(reward);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, round (3 - (_info / 40)), _durchmesser));
			#endif
		};
		case "suizidgefaehrdet":
		{
			#ifndef TEST
				[_main_task, "targets", [2,_durchmesser]] call FUNC(reward);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser));
			#endif
		};
		case "nichts":
		{
			#ifndef TEST
				[_main_task, "targets", [2,_durchmesser]] call FUNC(reward);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser));
			#endif
		};
	};
	hint localize LSTRING(SIDE_UEBERLAEUFER_VERHOERT);
	
	[LSTRING(SIDE_SIDEMISSION),[LSTRING(SIDE_FINISHED)],"",false] call EFUNC(interface,disp_info_global);
	[_task, "Succeeded", false] call BIS_fnc_taskSetState;
	missionNamespace setVariable [QGVAR(current_sidemission),""];
} else {
	hint localize LSTRING(SIDE_UEBERLAEUFER_NICHT_VERHOERT);

	[LSTRING(SIDE_SIDEMISSION),[LSTRING(SIDE_FAILED)],"",false] call EFUNC(interface,disp_info_global);
	[_task, "Failed", false] call BIS_fnc_taskSetState;
	missionNamespace setVariable [QGVAR(current_sidemission),""];
};

if ( (damage _ueberlaeufer) < 1 ) then { deleteVehicle _ueberlaeufer; };
