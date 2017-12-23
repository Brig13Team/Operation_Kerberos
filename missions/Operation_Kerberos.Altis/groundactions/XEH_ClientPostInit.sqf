/**
 * Author: Dorbedo
 * PostInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(hasInterface) exitWith {};

private _action = [
    QGVAR(Inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
    {ACE_player action ["Gear", _target];},
    LINKFUNC(canPickUp),
    LINKFUNC(addPickUpSubAction),
    []
] call ace_interact_menu_fnc_createAction;

["GroundWeaponHolder", 0] call ace_interact_menu_fnc_addMainAction;
["GroundWeaponHolder", 0, ["ACE_MainAction"], _action] call ace_interact_menu_fnc_addActionToClass;

private _action = [
    QGVAR(Inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
    {ACE_player action ["Gear", _target];},
    {!alive _target},
    {},
    []
] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainAction"], _action] call ace_interact_menu_fnc_addActionToClass;
