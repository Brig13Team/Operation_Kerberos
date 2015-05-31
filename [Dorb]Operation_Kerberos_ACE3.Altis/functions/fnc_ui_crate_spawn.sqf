/*
	Author: Dorbedo

	Description:
		spawns the cosen box with including items
	
*/
#include "script_component.hpp"


/// Clear Pad


_check_radius = 8;
_spawnpos = getMarkerPos "crate_spawn";

{if (count crew _x == 0) then {deletevehicle _x};} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

_padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];

If (!(_padempty isEqualTo [])) exitWith {hint localize "STR_DORB_SPAWN_NOTEMPTY";};

_boxtyp = (DORB_CRATE_BOXES select 0) select DORB_CRATE_CURRENT_BOXID;

_box = createVehicle [_boxtyp, _spawnpos, [], 0 , "NONE"];
_box setPosATL _spawnpos;

clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

_items = DORB_CRATE_CURRENT select 0;
_anzahl = DORB_CRATE_CURRENT select 1;

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

_items = DORB_CRATE_CURRENT select 2;
_anzahl = DORB_CRATE_CURRENT select 3;
{
	_box addMagazineCargoGlobal [configname (_x),(_anzahl select _foreachindex)];
}forEach _items;

disableSerialization;
closeDialog 600200;