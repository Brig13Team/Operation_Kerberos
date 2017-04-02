/*
    Author: Dorbedo

    Description:
        spawns the cosen box with including items

*/
#define INCLUDE_GUI
#include "script_component.hpp"
/// Clear Pad

private _check_radius = 8;
private _spawnpos = getPos GVAR(currentSpawn);
private _spawndir = getDir GVAR(currentSpawn);

[_spawnpos,_check_radius] call FUNC(clearPos);

private _padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];

If (!(_padempty isEqualTo [])) exitWith {hint localize LSTRING(NOTEMPTY);};

private _boxtyp = (GVAR(crate_boxes) select 0) select GVAR(current_boxid);
private _box = createVehicle [_boxtyp, _spawnpos, [], 0 , "NONE"];
_box setPosATL _spawnpos;
_box setDir _spawndir;

clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

private _items = GVAR(current) select 0;
private _anzahl = GVAR(current) select 1;

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

_items = GVAR(current) select 2;
_anzahl = GVAR(current) select 3;
{
    _box addMagazineCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
}forEach _items;

[QEGVAR(logistics,setContainerWeight),_box] call CBA_fnc_localEvent;
["CRATE_SPAWNED",[_box]] spawn CBA_fnc_ServerEvent;
disableSerialization;
closeDialog IDD_CRATE_DLG;
[] spawn EFUNC(gui_echidna,close);
