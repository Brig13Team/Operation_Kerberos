/*
	Author: Dorbedo
	
	Description:
		returns an difficulty level depending on the amount of players

*/
#include "script_component.hpp"
SCRIPT(dyn_difficulty);
private "_playeramount";
_playeramount = {isplayer _x;} count playableUnits;

If (dorb_debug) exitWith {LOG("Difficultylevel=test");5;};
If (_playeramount < 12) exitWith {LOG("Difficultylevel=1");1;};
If (_playeramount < 20) exitWith {LOG("Difficultylevel=2");2;};
If (_playeramount < 26) exitWith {LOG("Difficultylevel=3");3;};
If (_playeramount < 32) exitWith {LOG("Difficultylevel=4");4;};
LOG("Difficultylevel=5");
5;