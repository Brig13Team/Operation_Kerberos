/*
    Author: Dorbedo

    Description:
        gets vehiclelist, creates dialog
        called Via dialog

    Parameter(s):
        0:OBJECT    - Caller
        3:ARRAy     - Paramter
            0:STRING    - Spawnname
            1:OBJECT    - Object where the Data is stored

*/
#include "script_component.hpp"
#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_header_idc 600101
#define dlg_veh_spawn_list_idc 600102

_this params ["_caller"];
(_this select 3) params ["_spawnname","_host"];
private _check_radius = 10;//radius for vehicle spawn pad check and delete

private _spawnmarker = GETVAR(_host,GVAR(spawn_point),"");
private _vehiclelist = GETVAR(_host,GVAR(spawn_list),[]);

CHECK(_spawnmarker isEqualto "")
CHECK(_vehiclelist isEqualto [])
SETMVAR(GVAR(spawn_current),_host);

private _spawnpos = getMarkerPos _spawnmarker;
// EMPTY SPAWNPAD
{
    { if(!(alive _x)) then { deleteVehicle _x; }; } forEach (crew _x);
    if (count crew _x == 0) then {deletevehicle _x};
    if (( (getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "vehicleClass"))isEqualTo "Autonomous")) then {_x TILGE;};
} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

disableSerialization;
createDialog QGVAR(veh_spawn);
ctrlSetText[dlg_veh_spawn_header_idc,_spawnname];
private _sel = [];
for "_i" from 0 to ((count _vehiclelist)-1) do {
    private _vehicle = _vehiclelist select _i;
    _sel pushBack [["",format["%1",(_vehicle select 2)],format["| %1",(_vehicle select 3),""]],[],[(_vehicle select 0),(_vehicle select 1),(_vehicle select 4),format["%1",(_vehicle select 5),""]]];
};

private _ctrlList = findDisplay dlg_veh_spawn_idd displayCtrl dlg_veh_spawn_list_idc;

lnbClear dlg_veh_spawn_list_idc;
lnbAddArray [dlg_veh_spawn_list_idc,_sel];

if(((lnbSize _ctrlList) select 0)>0) then {lbSetCurSel [dlg_veh_spawn_list_idc, 1];};

for "_i" from 0 to ((lnbSize _ctrlList) select 0) do {
    private _pic = _ctrlList lnbData [_i,1];
    if (!(_pic in ["pictureThing","pictureStaticObject","iconobject_1x3"])) then {
        _ctrlList lnbSetPicture [ [_i, 0],(_ctrlList lnbData [_i,1])];
    };
};