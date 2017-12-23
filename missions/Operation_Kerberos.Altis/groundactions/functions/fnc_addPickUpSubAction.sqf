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
params [["_weaponholder", objNull, [""]]];

If (isNull _weaponholder) exitWith {[]};

private _pickUpActions = [];

{
    private _action = [
        format[QGVAR(pickup_%1), _x],
        format[LSTRING(take), [_x, "displayName", ""] call EFUNC(common,getCfgWeapons)],
        [_x, "picture", ""] call EFUNC(common,getCfgWeapons),
        {ACE_player action ["Take", _this select 0, _this select 1];},
        {true},
        {},
        [_weaponholder, _x]
    ] call ace_interact_menu_fnc_createAction;
    _pickUpActions pushBack [_action, [], _weaponholder];
    nil
} count (weaponCargo _weaponholder);
