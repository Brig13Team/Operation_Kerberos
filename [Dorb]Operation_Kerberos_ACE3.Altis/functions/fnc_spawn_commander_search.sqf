/*
	Author: Dorbedo
	
	Description:
	Type 0 : Nur Boden (inkl. Fahrzeuge)
	Type 1 : Nur Luft
	Type 2 : Nur Fahrzeuge
	
	
	Parameter(s):
		0 : ARRAY	- Position of Commandoveh
		1 : SCALAR	- Type
	
	Return
	BOOL
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(spawn_commander_search);
params["_pos",["_type",0,[0]]];
Private["_player_pos","_players","_targets","_return","_level"];
_players = [];
_targets = [];

_players = call CBA_fnc_players;

switch (_type) do {
	case 0 : {
		{
			_level = dorb_side knowsAbout _x;
			If ((_level >= 0.5)&&(!((vehicle _x) isKindOf "Air"))) then {
				_player_pos = getPos _x;
				if ((_player_pos distance _pos) < 2000) then {
					_targets pushBack (_x);
				};
			};
		}forEach _players;
	};
	case 1 : {
		{
			If (((vehicle _x) isKindOf "Air")&&(!((vehicle _x) isKindOf "ParachuteBase"))) then {
				_player_pos = getPosATL _x;
				if ((_player_pos distance _pos) < 5000) then {
					_targets pushBack (_x);
				};
			};
		}forEach _players;
	};
	case 2 : {
		{
			_level = dorb_side knowsAbout _x;
			If ((_level >= 0.5)&&((vehicle _x) isKindOf "LandVehicle")) then {
				_player_pos = getPos _x;
				if ((_player_pos distance _pos) < 2000) then {
					_targets pushBack (_x);
				};
			};
		}forEach _players;
	};
	case 3 : {
		{
			_level = dorb_side knowsAbout _x;
			If ((_level >= 0.5)&&((vehicle _x) isKindOf "Man")) then {
				_player_pos = getPos _x;
				if ((_player_pos distance _pos) < 2000) then {
					_targets pushBack (_x);
				};
			};
		}forEach _players;
	};
};
TRACE_1("Ziele=%1",_targets);
_targets;