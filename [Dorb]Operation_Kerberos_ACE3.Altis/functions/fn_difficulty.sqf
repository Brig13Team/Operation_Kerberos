/*
	Author: Dorbedo
	
	Description:
	

*/
#include "script_component.hpp"

private ["_players"];

_players = call CBA_fnc_players;

If (dorb_debug) exitWith {d_log("Difficultylevel=test")5};
If (count _players < 12) exitWith {d_log("Difficultylevel=1")1};
If (count _players < 20) exitWith {d_log("Difficultylevel=2")2};
If (count _players < 26) exitWith {d_log("Difficultylevel=3")3};
If (count _players < 32) exitWith {d_log("Difficultylevel=4")4};
d_log("Difficultylevel=5")5