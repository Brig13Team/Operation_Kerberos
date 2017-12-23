/**
 * Author: Dorbedo
 * PostInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(hasInterface) exitWith {};

private _action = [
    QGVAR(pickup),
    localize LSTRING(PICKUP),
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
    {},
    LINKFUNC(canPickUp),
    LINKFUNC(addSubAction),
    []
] call ace_interact_menu_fnc_createAction;

["GroundWeaponHolder", 0] call ace_interact_menu_fnc_addMainAction;
["GroundWeaponHolder", 0, ["ACE_MainAction"], _action] call ace_interact_menu_fnc_addActionToClass;
