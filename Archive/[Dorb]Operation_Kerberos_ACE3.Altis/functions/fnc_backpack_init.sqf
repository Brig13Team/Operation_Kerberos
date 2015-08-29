/*
	Author: Dorbedo
	
	Description:
		Backpack on Chest
		Init
*/

#include "script_component.hpp"
SCRIPT(backpack_init);
private "_ACE_Action";
_ACE_Action = ["DORB_BACKPACK_CHEST", localize "STR_DORB_BACKPACK_CHEST", "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa", {[true] call FM(backpack_change);}, {(!((backpack player) isEqualTo ""))and(isNull (GETVAR(player,DORB_BACKPACK_PACK,objNull)))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
_ACE_Action = ["DORB_BACKPACK_BACK", localize "STR_DORB_BACKPACK_BACK", "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa", {[false] call FM(backpack_change);}, {((backpack player) isEqualTo "")and(!(isNull (GETVAR(player,DORB_BACKPACK_PACK,objNull))))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;