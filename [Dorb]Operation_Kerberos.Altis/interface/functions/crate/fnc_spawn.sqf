/*
    Author: Dorbedo

    Description:
        spawns the cosen box with including items

*/
#include "script_component.hpp"
/// Clear Pad

private _check_radius = 8;
private _spawnpos = getMarkerPos format["%1_marker",GVAR(crate_currentSpawn)];
private _spawndir = markerDir format["%1_marker",GVAR(crate_currentSpawn)];

{if (count crew _x == 0) then {deletevehicle _x};} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

private _padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];

If (!(_padempty isEqualTo [])) exitWith {hint localize LSTRING(NOTEMPTY);};

private _boxtyp = (GVAR(crate_boxes) select 0) select GVAR(crate_current_boxid);
private _box = createVehicle [_boxtyp, _spawnpos, [], 0 , "NONE"];
_box setPosATL _spawnpos;
_box setDir _spawndir;

clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

private _items = GVAR(crate_current) select 0;
private _anzahl = GVAR(crate_current) select 1;

{
    private _name = ([_x]call BIS_fnc_configPath)select 1;
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

[_box] call EFUNC(logistics,setContainerWeight);
["CRATE_SPAWNED",[_box]] spawn EFUNC(events,serverEvent);
disableSerialization;
closeDialog 600200;