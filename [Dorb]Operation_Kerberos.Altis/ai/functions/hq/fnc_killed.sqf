/*
	Author: Dorbedo
	
	Description:
		killed
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(killed);

_this params ["_killer","_caller"];

_killerpos = _caller gethidefrom _killer

If ((_killerpos distance [0,0,0])<1) exitWith {};


