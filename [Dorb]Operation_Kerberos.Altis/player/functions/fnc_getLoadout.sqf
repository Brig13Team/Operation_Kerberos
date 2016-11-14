/*
 *  Author: Dorbedo
 *
 *  Description:
 *      takes the loadout and saves it globaly
 *
 *  Parameter(s):
 *      0 : OBJECT - the unit (usually the player)
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_unit"];

private _loadout = getUnitLoadout _unit;
If (!isNil QEFUNC(acrepatch,cleanLoadout)) then {
    _loadout = [_loadout] call EFUNC(acrepatch,cleanLoadout);
};

private _weaponsarray = [];
private _weapon = currentWeapon _unit;
private _muzzle = currentMuzzle _unit;
If ((!(_muzzle isEqualTo ""))&&{!(_weapon isEqualTo _muzzle)}&&{_muzzle in getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles")}) then {
    _weaponsarray = [currentMuzzle _unit, currentWeaponMode _unit];
}else{
    _weaponsarray = [currentWeapon _unit, currentWeaponMode _unit];
};

[_loadout,_weaponsarray];
