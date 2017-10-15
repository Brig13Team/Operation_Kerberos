/**
 * Author: Dorbedo
 * displays the possible boxes
 *
 * Arguments:
 * 0: <ARRAY> position
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_display"];

private _nearObjects = nearestObjects [GVAR(curPos), ["AllVehicles"], _check_radius];

// filter the Objects

//TODO


// create the list
private _list = [];
{
    _list pushBack [
        format ["%1 (New)",getText(configFile >> "CfgVehicles" >> _x)],
        _x,
        0
    ];
    nil
} count ["Box_NATO_Ammo_F","Box_NATO_WpsLaunch_F","Box_NATO_Wps_F","Box_NATO_WpsSpecial_F","IG_supplyCrate_F","B_CargoNet_01_ammo_F","B_Slingload_01_Cargo_F"];

{
    _list pushBack [
        format [localize LSTRING(NEWBOX),getText(configFile >> "CfgVehicles" >> (typeOf _x))],
        [_x] call BIS_fnc_netId,
        1
    ];
} count _nearObjects;



private _ctrlLb = (_display) displayCtrl IDD_GUI_CRATE_BOXLIST;
{
    _x params ["_text","_data","_value"];
    private _index = _ctrlLb lbAdd _text;
    _ctrlLb lbSetData _data;
    _ctrlLb lbSetValue _value;
} forEach _list;
