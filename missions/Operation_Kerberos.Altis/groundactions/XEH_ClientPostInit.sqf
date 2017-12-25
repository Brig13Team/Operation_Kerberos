/**
 * Author: Dorbedo
 * PostInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(hasInterface) exitWith {};

private _action = [
    QGVAR(open_inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa",
    {ACE_player action ["Gear", _target];},
    {(!alive _target) && {GVAR(active)}},
    {_target call FUNC(addInventorySubActions)},
    []
] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

private _action = [
    QGVAR(open_inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa",
    {ACE_player action ["Gear", _target];},
    {GVAR(active)},
    {_target call FUNC(addPickUpSubActions)},
    [],
    [0, 0, -0.5]
] call ace_interact_menu_fnc_createAction;

["WeaponHolderSimulated", 0, [], _action] call ace_interact_menu_fnc_addActionToClass;
["GroundWeaponHolder", 0, [], _action] call ace_interact_menu_fnc_addActionToClass;

private _action = [
    QGVAR(open_inventory),
    localize LSTRING(Inventory),
    "\A3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa",
    {ACE_player action ["Gear", _target];},
    {GVAR(active)},
    {_target call FUNC(addPickUpSubActions)},
    []
] call ace_interact_menu_fnc_createAction;

{
    private _configName = configName _x;
    [_configName, 0, [], _action] call ace_interact_menu_fnc_addActionToClass;
    nil
} count (configProperties [configFile >> "CfgVehicles", "(isClass _x) && {getNumber(_x >> 'scope') > 1} && {configName _x isKindOf 'WeaponHolder'}", true]);
