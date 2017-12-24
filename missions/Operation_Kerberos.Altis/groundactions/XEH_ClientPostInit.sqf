/**
 * Author: Dorbedo
 * PostInit
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(hasInterface) exitWith {};

private _action = [
    QGVAR(open_inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\backpack_ca.paa",
    {ACE_player action ["Gear", _target];},
    {(!alive _target) && {GVAR(active)}},
    {_target call FUNC(addInventorySubActions)},
    []
] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

private _action = [
    QGVAR(open_inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\backpack_ca.paa",
    {ACE_player action ["Gear", _target];},
    {GVAR(active)},
    {_target call FUNC(addPickUpSubActions)},
    [],
    [0, 0, -0.5]
] call ace_interact_menu_fnc_createAction;

TRACEV_1(_action);

//private _ret1 = ["WeaponHolder", 0] call ace_interact_menu_fnc_addMainAction;
//private _ret1 = ["WeaponHolderSimulated", 0] call ace_interact_menu_fnc_addMainAction;
private _ret2 = ["WeaponHolderSimulated", 0, [], _action] call ace_interact_menu_fnc_addActionToClass;
TRACEV_2(_ret1,_ret2);


