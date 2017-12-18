//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

[QGVAR(delete),FUNC(delete)] call CBA_fnc_addEventHandler;
[QGVAR(setPylonLoadOut),{
    params ["_aircraft", "_pylon", ["_ammo", "", [""]], ["_forced", true, [true]], ["_turret", [], [[]]]];
    _aircraft setPylonLoadOut [_pylon, _ammo, _forced, _turret];
}] call CBA_fnc_addEventHandler;

[
    QGVAR(disableCollisionWith),
    {
        (_this select 0) disableCollisionWith (_this select 1);
    }
] call CBA_fnc_addEventHandler;
[
    QEGVAR(common,setVehicleAmmo),
    {
        _this params ["_vehicle",["_ammo",1,[0]]];
        _vehicle setVehicleAmmo _ammo;
    }
] call CBA_fnc_addEventHandler;
[
    QEGVAR(common,enableCollision),
    {
        params ["_vehicle","_cargo"];
        _vehicle enableCollisionWith _cargo;
    }
] call CBA_fnc_addEventHandler;

ISNIL(cfgWeaponCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgVehicleCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgAmmoCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgMagazineCacheLocal,false call CBA_fnc_createNamespace);
