/*
    Author: iJesuz

    Description:
        set container weight

    Parameter(s):
        0 : STRING - mode
*/
#include "script_component.hpp"

_this params[["_container",objNull,[objNull]]];

If !(isNil "ace_dragging_fnc_getweight") exitWith {
    private _mass = [_container] call ace_dragging_fnc_getweight;
    _container setMass _mass;
    If (isNil(_container getVariable QGVAR(emptyMass))) then {
        _container setVariable [QGVAR(emptyMass),getMass _container,true];
    };
};

if (not (_container isKindOf "ReammoBox_f")) exitWith {};

private _cweight = _container getVariable [QGVAR(emptyMass), getMass _container];
private _iweight = 0;

private _itemCargo = getItemCargo _container;
for "_i" from 0 to (count (_itemCargo select 0) - 1) do {
    if (isNumber (configFile >> "CfgWeapons" >> (_itemCargo select 0 select _i) >> "ItemInfo" >> "mass")) then {
        _iweight = _iweight + (getNumber(configFile >> "CfgWeapons" >> (_itemCargo select 0 select _i) >> "ItemInfo" >> "mass") * (_itemCargo select 1 select _i));
    };
};

_itemCargo = getWeaponCargo _container;
for "_i" from 0 to (count (_itemCargo select 0) - 1) do {
    if (isNumber (configFile >> "CfgWeapons" >> (_itemCargo select 0 select _i) >> "WeaponSlotsInfo" >> "mass")) then {
        _iweight = _iweight + (getNumber(configFile >> "CfgWeapons" >> (_itemCargo select 0 select _i) >> "WeaponSlotsInfo" >> "mass") * (_itemCargo select 1 select _i));
    };
};

_itemCargo = getMagazineCargo _container;
for "_i" from 0 to (count (_itemCargo select 0) - 1) do {
    if (isNumber (configFile >> "CfgMagazines" >> (_itemCargo select 0 select _i) >> "mass")) then {
        _iweight = _iweight + (getNumber(configFile >> "CfgMagazines" >> (_itemCargo select 0 select _i) >> "mass") * (_itemCargo select 1 select _i));
    };
};

_itemCargo = getBackpackCargo _container;
for "_i" from 0 to (count (_itemCargo select 0) - 1) do {
    if (isNumber (configFile >> "CfgVehicles" >> (_itemCargo select 0 select _i) >> "mass")) then {
        _iweight = _iweight + (getNumber(configFile >> "CfgVehicles" >> (_itemCargo select 0 select _i) >> "mass") * (_itemCargo select 1 select _i));
    };
};

_container setMass ((_iweight + _cweight)*0.5);
_container setVariable [QGVAR(emptyMass),_cweight,true];
