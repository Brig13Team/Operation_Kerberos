/*
	Author: Dorbedo

	Description:
		checks container for restricted Materials

*/
#include "script_component.hpp"
_this params [["_container",objNull,[objNull]]];
CHECK(isNull _container)

If !(isClass(missionConfigFile>>QGVAR(arsenal))) exitWith {};





private _blacklist = (getArray(missionConfigFile>>QGVAR(arsenal)>> "ItemsBlacklist"));
private _inventoryToCheck = getItemCargo _container;
If (({_x in _blacklist} count (_inventoryToCheck select 0))>0) then {
    clearItemCargoGlobal _container;
    {
        If !(_x in _blacklist) then {
            _container addItemCargoGlobal [_x, (_inventoryToCheck select 1) select _foreachindex];
        }
    } forEach (_inventoryToCheck select 0);
};

_blacklist = getArray(missionConfigFile>>QGVAR(arsenal)>> "BackpackBlacklist");
_inventoryToCheck = getBackpackCargo _container;
If (({_x in _blacklist} count (_inventoryToCheck select 0))>0) then {
    clearBackpackCargoGlobal _container;
    {
        If !(_x in _blacklist) then {
            _container addBackpackCargoGlobal [_x, (_inventoryToCheck select 1) select _foreachindex];
        }
    } forEach (_inventoryToCheck select 0);
};

_blacklist = (getArray(missionConfigFile>>QGVAR(arsenal)>> "WeaponsBlacklist"));
_inventoryToCheck = getWeaponCargo _container;
If (({_x in _blacklist} count (_inventoryToCheck select 0))>0) then {
    clearWeaponCargoGlobal _container;
    {
        If !(_x in _blacklist) then {
            _container addWeaponCargoGlobal [_x, (_inventoryToCheck select 1) select _foreachindex];
        }
    } forEach (_inventoryToCheck select 0);
};

_blacklist = getArray(missionConfigFile>>QGVAR(arsenal)>> "MagazineBlackList");
_inventoryToCheck = getMagazineCargo _container;
If (({_x in _blacklist} count (_inventoryToCheck select 0))>0) then {
    clearMagazineCargoGlobal _container;
    {
        If !(_x in _blacklist) then {
            _container addMagazineCargoGlobal [_x, (_inventoryToCheck select 1) select _foreachindex];
        }
    } forEach (_inventoryToCheck select 0);
};
