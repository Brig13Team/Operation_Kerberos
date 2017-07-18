/*
 *  Author: Dorbedo
 *
 *  Description:
 *      used to debug the arsenal templates and find the items, why the predefinitions can't be loaded
 *
 *  Parameter(s):
 *      0 : OBJECT - teh virtul box
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_NORMAL
#include "script_component.hpp"

#define CONDITION(LIST)	(("%ALL" in LIST) || {{_item == _x} count LIST > 0})

_this params [["_box",objNull,[objNull]]];

private _data = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
private _cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",_box]);

private _virtualItemCargo =
    (missionnamespace call bis_fnc_getVirtualItemCargo) +
    (_cargo call bis_fnc_getVirtualItemCargo) +
    items _center +
    assigneditems _center +
    primaryweaponitems _center +
    secondaryweaponitems _center +
    handgunitems _center +
    [uniform _center,vest _center,headgear _center,goggles _center];
private _virtualWeaponCargo = [];
{
    _weapon = _x call bis_fnc_baseWeapon;
    _virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];
    {
        private ["_item"];
        _item = gettext (_x >> "item");
        if !(_item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_item];};
    } foreach ((configfile >> "cfgweapons" >> _x >> "linkeditems") call bis_fnc_returnchildren);
} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_cargo call bis_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);
private _virtualMagazineCargo = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_cargo call bis_fnc_getVirtualMagazineCargo) + magazines _center;
private _virtualBackpackCargo = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_cargo call bis_fnc_getVirtualBackpackCargo) + [backpack _center];

private _loadingScreenStep = 1/(count _data);
private _loadingScreenID = [localize LSTRING(DEBUGARSENAL)] call EFUNC(gui,startLoadingScreen);

for "_i" from 0 to (count _data - 1) step 2 do {
    private _name = _data select _i;
    private _inventory = _data select (_i + 1);

    private _inventoryWeapons = [
        (_inventory select 5), //--- Binocular
        (_inventory select 6 select 0), //--- Primary weapon
        (_inventory select 7 select 0), //--- Secondary weapon
        (_inventory select 8 select 0) //--- Handgun
    ] - [""];
    private _inventoryMagazines = (
        (_inventory select 0 select 1) + //--- Uniform
        (_inventory select 1 select 1) + //--- Vest
        (_inventory select 2 select 1) //--- Backpack items
    ) - [""];
    private _inventoryItems = (
        [_inventory select 0 select 0] + (_inventory select 0 select 1) + //--- Uniform
        [_inventory select 1 select 0] + (_inventory select 1 select 1) + //--- Vest
        (_inventory select 2 select 1) + //--- Backpack items
        [_inventory select 3] + //--- Headgear
        [_inventory select 4] + //--- Goggles
        (_inventory select 6 select 1) + //--- Primary weapon items
        (_inventory select 7 select 1) + //--- Secondary weapon items
        (_inventory select 8 select 1) + //--- Handgun items
        (_inventory select 9) //--- Assigned items
    ) - [""];
    private _inventoryBackpacks = [_inventory select 2 select 0] - [""];

    private _missingWeapons = [];
    private _missingMagazines = [];
    private _missingItems = [];
    private _missingBackpacks = [];

    {
        private _item = _x;
        If (!CONDITION(_virtualWeaponCargo) || !isclass(configfile >> "cfgweapons" >> _item)) then {
            _missingWeapons pushBack _item;
            true;
        };
        nil;
    } count _inventoryWeapons;
    {
        private _item = _x;
        If (!CONDITION(_virtualItemCargo + _virtualMagazineCargo) || {isclass(configfile >> _x >> _item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0) then {
            _missingMagazines pushBack _item;
            true;
        };
        nil;
    } count _inventoryMagazines;
    {
        private _item = _x;
        If (!CONDITION(_virtualItemCargo + _virtualMagazineCargo) || {isclass(configfile >> _x >> _item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0) then {
            _missingItems pushBack _item;
        };
        nil;
    } count _inventoryItems;
    {
        private _item = _x;
        If (!CONDITION(_virtualBackpackCargo) || !isclass(configfile >> "cfgvehicles" >> _item)) then {
            _missingBackpacks pushBack _item;
            true;
        };
        nil;
    } count _inventoryBackpacks;
    LOG_5(_name,_missingWeapons,_missingMagazines,_missingItems,_missingBackpacks);
    [_loadingScreenID,(_i * _loadingScreenStep)] call EFUNC(gui,progressLoadingScreen);
};
[_loadingScreenID] call EFUNC(gui,endLoadingScreen);
