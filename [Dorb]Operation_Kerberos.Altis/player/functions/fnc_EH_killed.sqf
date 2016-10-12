
#include "script_component.hpp"
SCRIPT(XEH_killed);

CHECK(!hasInterface)
_this params ["_unit"];

private _loadout = getUnitLoadout _unit;
If (!isNil QEFUNC(patchacre,cleanLoadout)) then {
    _loadout = [_loadout] call EFUNC(patchacre,cleanLoadout);
};
GVAR(respawnLoadout) = _loadout;

private _weapon = currentWeapon _unit;
private _muzzle = currentMuzzle _unit;
If ((!(_muzzle isEqualTo ""))&&{!(_weapon isEqualTo _muzzle)}&&{_muzzle in getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles")}) then {
    GVAR(Weapons) = [currentMuzzle _unit, currentWeaponMode _unit];
}else{
    GVAR(Weapons) = [currentWeapon _unit, currentWeaponMode _unit];
};
