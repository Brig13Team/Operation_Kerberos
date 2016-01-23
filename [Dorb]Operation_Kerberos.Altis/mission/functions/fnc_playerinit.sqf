/*
    Author: Dorbedo
    
    Description:
        init function for player
    
*/
#include "script_component.hpp"
SCRIPT(playerinit);
CHECK(!hasinterface)
private ["_ACE_Action"];

///// suitcase actions
_ACE_Action = [QGVAR(objects_carry), localize LSTRING(OBJECTS_CARRY), "", {[_target,player] spawn FUNC(objects_carry);}, {(isNull (_target getVariable [QGVAR(objects_carrier),objNull]))}] call ace_interact_menu_fnc_createAction;
["Land_Suitcase_F", 0, ["ACE_MainActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToClass;
_ACE_Action = [QGVAR(objects_drop), localize LSTRING(OBJECTS_DROP), "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa", {[player] call FUNC(objects_drop);}, {!(isNull (GETVAR(player,GVAR(objects_suitcase),objNull)))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;

///// Device
private _devicetypes = ["Land_Device_assembled_F","rhs_typhoon_vdv"];
{
    _ACE_Action = [QGVAR(objects_disable), localize LSTRING(OBJECTS_DISABLE), "", {[_target,player] spawn FUNC(objects_disable);}, {[_target] call FUNC(objects_canDisable)}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToClass;
}forEach _devicetypes;

