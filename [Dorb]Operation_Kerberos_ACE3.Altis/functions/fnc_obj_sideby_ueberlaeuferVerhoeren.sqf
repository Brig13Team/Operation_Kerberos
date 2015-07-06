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

private ["_ueberlaeufer", "_eigenschaft", "_task", "_main_task", "_info", "_suizidtimer", "_ueberlaeuferPosition", "_ziel", "_liste", "_counter", "_kontakt", "_durchmesser"];

_ueberlaeufer = _this select 0;
_eigenschaft = _this select 1;
_task = _this select 2 select 0;
_main_task = _this select 2 select 1;

_info = 100;
_ziel = getMarkerPos "rescue_marker";

_suizidtimer = 0;
_kontakt = 0;

while { ((((getPos _ueberlaeufer) distance _ziel) > 20) OR (captive _ueberlaeufer)) AND (alive _ueberlaeufer)} do {
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

	if (_suizidtimer >= 2) exitWith {
		_info = 0;
		_ueberlaeufer setDamage 1;
	};
};

_info = _info / 100;

if ( (_info > 0) and (alive _ueberlaeufer) ) then {
	_durchmesser = 50;
	switch (_eigenschaft) do
	{
		case "Flugangst":
		{
			#ifndef TEST
				["random", _main_task, [2, 0, _durchmesser * (2 - _info), _durchmesser]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser * (2 - _info)));
			#endif
		};
		case "Paranoia":
		{
			#ifndef TEST
				["random", _main_task, [2, round (3 - (_info / 40)), _durchmesser, _durchmesser]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, round (3 - (_info / 40)), _durchmesser));
			#endif
		};
		case "suizidgefaehrdet":
		{
			#ifndef TEST
				["random", _main_task, [2, 0, _durchmesser, _durchmesser]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser));
			#endif
		};
		case "nichts":
		{
			#ifndef TEST
				["random", _main_task, [2, 0, _durchmesser, _durchmesser]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, _durchmesser));
			#endif
		};
	};
	hint "Überläufer wurde erfolgreich verhört!";

	#ifdef TEST
		LOG("[SIDEBY] Überläufer abgeschlossen!");
	#else
		_task setTaskState "Succeeded";
	#endif
} else {
	hint "Überläufer konnte nicht erfolgreich verhört werden!";

	#ifdef TEST
		LOG("[SIDEBY] Überläufer gescheitert!");
	#else
		_task setTaskState "Failed";
	#endif
};

if ( (damage _ueberlaeufer) < 1 ) then { deleteVehicle _ueberlaeufer; };
