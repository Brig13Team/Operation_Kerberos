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
DORB_HUD_EH = -1;
[
	{
		/// disable Hud if Player left the plane
		If ((DORB_HUD_EH >= 0)&&{(vehicle player == player)}) exitWith {
			[DORB_HUD_EH] call CBA_fnc_removePerFrameHandler;
			DORB_HUD_EH=-1;
		};
		/// Check if player has an Helemt with Interface
		If (!((headgear player)in(getArray(missionConfigFile >> "hud" >> "headgear")))) exitWith {
			/// remove the hud, if player threw his helmet away
			If (DORB_HUD_EH >= 0) then {
				[DORB_HUD_EH] call CBA_fnc_removePerFrameHandler;
				DORB_HUD_EH=-1;
			};
		};
		/// Check if vehicle of player is Aircraft -> setup the hud 
		If ( ((vehicle player) isKindOf "Air") && { (DORB_HUD_EH < 0) } && { GETVAR(vehicle player,DORB_HUD_ENABLED,true)}) then {
			/// Exit if Aircraft is not configured  
			If (!(isClass(missionConfigFile >> "hud" >> "Aircraft" >> (typeOf(vehicle player))))) exitWith {
				SETVAR(vehicle player,DORB_HUD_ENABLED,false);
			};
			
			/// Setup the Smoothing
			DORB_HUD_SMOOTHING = [];
			for "_i" from 0 to FRAMES do {
				DORB_HUD_SMOOTHING pushBack [0,0,0];
			};
			
			DORB_HUD_EH = [
					{
						_this call FM(hud_show);
					},
					0,
					[vehicle player] 
				] call CBA_fnc_addPerFrameHandler;
		};
	},
	15,
	[] 
] call CBA_fnc_addPerFrameHandler;
