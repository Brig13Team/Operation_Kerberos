/*
    Author: Dorbedo

    Description:
        spawns the cosen box with including items

*/
#include "script_component.hpp"
SCRIPT(spawn);
private["_check_radius","_spawnpos","_padempty","_box","_boxtyp","_items","_anzahl","_name"];
/// Clear Pad

_check_radius = 8;
_spawnpos = getMarkerPos "crate_spawn";

{if (count crew _x == 0) then {deletevehicle _x};} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

_padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];

If (!(_padempty isEqualTo [])) exitWith {hint localize LSTRING(NOTEMPTY);};

_boxtyp = (GVAR(crate_boxes) select 0) select GVAR(crate_current_boxid);
_box = createVehicle [_boxtyp, _spawnpos, [], 0 , "NONE"];
_box setPosATL _spawnpos;

clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

_items = GVAR(crate_current) select 0;
_anzahl = GVAR(crate_current) select 1;

{
    _name = ([_x]call BIS_fnc_configPath)select 1;
    If (_name isEqualTo "CfgVehicles") then {
        _box addBackpackCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
    }else{
        If (_name isEqualTo "CfgMagazines") then {
            _box addBackpackCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
        }else{
            If (!((getArray(_x>>"Magazines"))isEqualTo[])) then {
                _box addWeaponCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
            }else{
                _box addItemCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
            };
        };
    };
}forEach _items;

_items = GVAR(crate_current) select 2;
_anzahl = GVAR(crate_current) select 3;
{
    _box addMagazineCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
}forEach _items;

[QEGVAR(player,cleanCargoRestriction),[_box]] call CBA_fnc_localEvent;

disableSerialization;
closeDialog 600200;
