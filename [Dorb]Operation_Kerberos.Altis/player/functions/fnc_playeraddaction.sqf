/*
	Author: Dorbedo
	
	Description:
		adds a action to the player
		
	Parameter(s):
		none
		
	Return
		none
*/

#include "script_component.hpp"
SCRIPT(playeraddaction);
[["<t color='#FFFF00'>"+localize ELSTRING(interface,TFR_SHORT)+"</t>",{[]call EFUNC(interface,tfr_OpenMenu);},[],0.5,false,true,"","alive _target"]] call CBA_fnc_addPlayerAction;