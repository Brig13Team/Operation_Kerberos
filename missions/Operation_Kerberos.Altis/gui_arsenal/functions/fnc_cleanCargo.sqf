/*
 *  Author: Dorbedo
 *
 *  Description:
 *      cleans the cargo of an object
 *
 *  Parameter(s):
 *      0 : OBJECT - the object to check
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACEV_2(GVAR(level),_this);
If (GVAR(level)<1) exitWith {};

If !(canSuspend) exitWIth {
    _this spawn FUNC(cleanCargo);
};

If (!GVAR(isPreloaded)) then {
    [] call FUNC(preload);
};

params [["_container",objNull,[objNull]]];
TRACEV_1(_container);
private _weapons = weaponCargo _container;
private _backpacks = BackpackCargo _container;
private _items = itemCargo _container;
private _magazines = magazineCargo _container;

private _Flag_Weapons = [_weapons] call FUNC(isRestrictedArray);
private _Flag_backpacks = [_backpacks] call FUNC(isRestrictedArray);
private _Flag_items = [_items] call FUNC(isRestrictedArray);
private _Flag_magazines = [_magazines] call FUNC(isRestrictedArray);


If (_Flag_Weapons) then {
    {
        private _curValue = _x;
        If ([_curValue] call FUNC(isRestrictedArray)) then {
            [_container,_curValue,999999] call CBA_fnc_removeWeaponCargo;
        };
    } count (_weapons arrayIntersect _weapons);
};
If (_Flag_backpacks) then {
    {
        private _curValue = _x;
        If ([_curValue] call FUNC(isRestrictedArray)) then {
            [_container,_curValue,999999] call CBA_fnc_removeWeaponCargo;
        };
    } count (_backpacks arrayIntersect _backpacks);
};
If (_Flag_items) then {
    {
        private _curValue = _x;
        If ([_curValue] call FUNC(isRestrictedArray)) then {
            [_container,_curValue,999999] call CBA_fnc_removeItemCargo;
        };
    } count (_items arrayIntersect _items);
};
If (_Flag_magazines) then {
    {
        private _curValue = _x;
        If ([_curValue] call FUNC(isRestrictedArray)) then {
            [_container,_curValue,999999] call CBA_fnc_removeMagazineCargo;
        };
    } count (_magazines arrayIntersect _magazines);
};

If (_Flag_Weapons||_Flag_backpacks||_Flag_items||_Flag_magazines) then {
    ERROR_WITH_TITLE("Not allowed Items detected","Some items will be removed.");
};
