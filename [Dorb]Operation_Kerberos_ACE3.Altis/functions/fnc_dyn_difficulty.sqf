/*
	Author: Dorbedo
	
	Description:
	

*/
#include "script_component.hpp"

private ["_players"];

_players = call CBA_fnc_players;

If (dorb_debug) exitWith {LOG("Difficultylevel=test");5;};
If (count _players < 12) exitWith {LOG("Difficultylevel=1");1;};
If (count _players < 20) exitWith {LOG("Difficultylevel=2");2;};
If (count _players < 26) exitWith {LOG("Difficultylevel=3");3;};
If (count _players < 32) exitWith {LOG("Difficultylevel=4");4;};
LOG("Difficultylevel=5");
5;