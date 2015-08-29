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
SCRIPT(ui_spawn_Open);
#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_header_idc 600101
#define dlg_veh_spawn_list_idc 600102

PARAMS_1(_caller);
Private["_paramarray"];
_paramarray = _this select 3;
EXPLODE_2_PVT(_paramarray,_spawnname,_host);
Private["_check_radius","_spawnmarker","_vehiclelist","_spawnpos","_sel","_vehicle","_ctrlList","_pic"];
_check_radius = 10;//radius for vehicle spawn pad check and delete

_spawnmarker = GETVAR(_host,DORB_SPAWNPOINT,"");
_vehiclelist = GETVAR(_host,DORB_SPAWNLIST,[]);

CHECK(_spawnmarker isEqualto "")
CHECK(_vehiclelist isEqualto [])
SETMVAR(DORB_SPAWN_CURRENT,_host);

_spawnpos = getMarkerPos _spawnmarker;
// EMPTY SPAWNPAD
{
	if (count crew _x == 0) then {deletevehicle _x};
	if (( (getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "vehicleClass"))isEqualTo "Autonomous")) then {_x TILGE;};
} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

disableSerialization;
createDialog "dorb_veh_spawn";
ctrlSetText[dlg_veh_spawn_header_idc,_spawnname];
_sel = [];
for "_i" from 0 to ((count _vehiclelist)-1) do {
    _vehicle = _vehiclelist select _i;
    _sel pushBack [["",format["%1",(_vehicle select 2)],format["| %1",(_vehicle select 3),""]],[],[(_vehicle select 0),(_vehicle select 1),(_vehicle select 4),format["%1",(_vehicle select 5),""]]];
};

_ctrlList = findDisplay dlg_veh_spawn_idd displayCtrl dlg_veh_spawn_list_idc;

lnbClear dlg_veh_spawn_list_idc;
lnbAddArray [dlg_veh_spawn_list_idc,_sel];

if(((lnbSize _ctrlList) select 0)>0) then {lbSetCurSel [dlg_veh_spawn_list_idc, 1];};

for "_i" from 0 to ((lnbSize _ctrlList) select 0) do {
    _pic = _ctrlList lnbData [_i,1];
    if (!(_pic in ["pictureThing","pictureStaticObject"])) then {
        _ctrlList lnbSetPicture [ [_i, 0],(_ctrlList lnbData [_i,1])];
    };
};