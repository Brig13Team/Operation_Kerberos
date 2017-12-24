/**
 * Author: Dorbedo
 * adds the subactions to the inventory action
 *
 * Arguments:
 * 0: <OBJECT> target to open the inventory at
 *
 * Return Value:
 * <ARRAY> the ace sub actions
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

If (isNull _unit) exitWith {[]};

private _pickUpActions = [];

private _weapons = [];
{
    private _curWeaponHolder = _x;
    {
        _weapons pushBack [_curWeaponHolder, _x];
        nil;
    } count (weaponCargo _curWeaponHolder);
    nil
} count (_unit nearObjects ["WeaponHolderSimulated", 5]);

/*
{
    _weapons pushBack [_unit, _x];
    nil
} count (weapons _unit);
*/

{
    _x params ["_weaponHolder", "_weaponClass"];
    private _action = [
        format[QGVAR(pickupweapon_%1), _weaponClass],
        format[localize LSTRING(take), [_weaponClass, "displayName", ""] call EFUNC(common,getCfgWeapons)],
        [_weaponClass, "picture", ""] call EFUNC(common,getCfgWeapons),
        {
            TRACEV_1(_this);
            ACE_player action ["TakeWeapon", (_this select 2) select 0, (_this select 2) select 1];
        },
        {GVAR(active)},
        {},
        [_weaponholder, _weaponClass]
    ] call ace_interact_menu_fnc_createAction;
    private _displayname = [_weaponClass, "displayName", ""] call EFUNC(common,getCfgWeapons);
    //TRACEV_3(_weaponClass,_displayname,_action);
    _pickUpActions pushBack [_action, [], _unit];
    nil
} count _weapons;

If !((backPack _unit) isEqualTo "") then {
    private _backpack = backpack _unit;
    private _action = [
        format[QGVAR(pickupbackpack_%1), _unit],
        format[localize LSTRING(take), [_backpack, "displayName", ""] call EFUNC(common,getCfgVehicles)],
        [_backpack, "picture", ""] call EFUNC(common,getCfgVehicles),
        {ACE_player action ["AddBag", (_this select 2) select 0, (_this select 2) select 1];},
        {GVAR(active) && {(backPack ACE_player) isEqualTo ""}},
        {},
        [_unit, _backpack]
    ] call ace_interact_menu_fnc_createAction;
    _pickUpActions pushBack [_action, [], _unit];
};

_pickUpActions
