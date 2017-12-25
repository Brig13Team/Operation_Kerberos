/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the pickup actionchild
 *
 *  Parameter(s):
 *      0 : OBJECT - Weaponholder
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_weaponholder", objNull, [objNull]]];

If (isNull _weaponholder) exitWith {[]};

private _pickUpActions = [];

{
    private _action = [
        format[QGVAR(pickup_%1), _x],
        format[localize LSTRING(take), [_x, "displayName", ""] call EFUNC(common,getCfgWeapons)],
        [_x, "picture", ""] call EFUNC(common,getCfgWeapons),
        {ACE_player action ["TakeWeapon", (_this select 2) select 0, (_this select 2) select 1];},
        {GVAR(active)},
        {},
        [_weaponholder, _x]
    ] call ace_interact_menu_fnc_createAction;
    _pickUpActions pushBack [_action, [], _weaponholder];
    nil
} count (weaponCargo _weaponholder);


{
    private _action = [
        format[QGVAR(pickup_%1), _x],
        format[localize LSTRING(take), [_x, "displayName", ""] call EFUNC(common,getCfgVehicles)],
        [_x, "picture", ""] call EFUNC(common,getCfgVehicles),
        {ACE_player action ["AddBag", (_this select 2) select 0, (_this select 2) select 1];},
        {GVAR(active) && {(backPack ACE_player) isEqualTo ""}},
        {},
        [_weaponholder, _x]
    ] call ace_interact_menu_fnc_createAction;
    _pickUpActions pushBack [_action, [], _weaponholder];
    nil
} count (backpackCargo _weaponholder);

_pickUpActions
