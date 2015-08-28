/*
	Author: Dorbedo
	
	Description:
		HUD init
	
	Parameter(s):
		None
	
*/
#include "script_component.hpp"
#define FRAMES 15


SCRIPT(hud_init);
CHECK(!hasInterface)
GVAR(hud_eh) = -1;
[
	{
		/// disable Hud if Player left the plane
		If ((GVAR(hud_eh) >= 0)&&{(vehicle player == player)}) exitWith {
			[GVAR(hud_eh)] call CBA_fnc_removePerFrameHandler;
			GVAR(hud_eh)=-1;
		};
		/// Check if player has an Helemt with Interface
		If (!((headgear player)in(getArray(missionConfigFile >> "hud" >> "headgear")))) exitWith {
			/// remove the hud, if player threw his helmet away
			If (GVAR(hud_eh) >= 0) then {
				[GVAR(hud_eh)] call CBA_fnc_removePerFrameHandler;
				GVAR(hud_eh)=-1;
			};
		};
		/// Check if vehicle of player is Aircraft -> setup the hud 
		If ( ((vehicle player) isKindOf "Air") && { (GVAR(hud_eh) < 0) } && { GETVAR(vehicle player,GVAR(hud_enabled),true)}) then {
			/// Exit if Aircraft is not configured  
			If (!(isClass(missionConfigFile >> "hud" >> "Aircraft" >> (typeOf(vehicle player))))) exitWith {
				SETVAR(vehicle player,GVAR(hud_enabled),false);
			};
			
			/// Setup the Smoothing
			GVAR(hud_smoothing) = [];
			for "_i" from 0 to FRAMES do {
				GVAR(hud_smoothing) pushBack [0,0,0];
			};
			
			GVAR(hud_eh) = [
					{
						_this call FM(hud_show);
					},
					0,
					[vehicle player] 
				] call CBA_fnc_addPerFrameHandler;
		};
	},
	30,
	[] 
] call CBA_fnc_addPerFrameHandler;
