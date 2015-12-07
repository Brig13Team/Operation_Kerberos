/*
	Author: Dorbedo
	
	Description:
		init function
	
*/
#include "script_component.hpp"
SCRIPT(init);



CHECK(!hasinterface)



///// suitcase action
private ["_carry","_ACE_Action"];
_carry = [QGVAR(case_carry), localize LSTRING(CASE_CARRY), "", {[_target,player] spawn FUNC(suitcase_carry);}, {(isNull (_target getVariable [QGVAR(suitcase_carrier),objNull])}] call ace_interact_menu_fnc_createAction;
["Land_Suitcase_F", 0, ["ACE_MainActions"], _carry] call ace_interact_menu_fnc_addActionToClass;


_ACE_Action = [QGVAR(case_drop), localize LSTRING(CASE_DROP), "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa", {[player] call FUNC(suitcase_drop);}, {!(isNull (GETVAR(player,GVAR(suitcase_suitcase),objNull)))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;

