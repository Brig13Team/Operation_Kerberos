/*
	Author: Dorbedo

	Description:
	gets vehiclelist, creates dialog

	Parameter(s):
		
		TO DO

*/
#include "script_component.hpp"

#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_header_idc 600101
#define dlg_veh_spawn_list_idc 600102

d_log(FORMAT_1("Spawn - this=%1",_this))

//_host = _this select 0;
//_caller = _this select 1;

_caller = _this select 0;


_paramarray = _this select 3;
_spawnname = _paramarray select 0;
_host = _paramarray select 1;

_check_radius = 10;//radius for vehicle spawn pad check and delete

_spawnmarker = GETVAR(_host,DORB_SPAWNPOINT,"");
_vehiclelist = GETVAR(_host,DORB_SPAWNLIST,[]);

d_log(FORMAT_2("Spawnmarker=%1 / Vehiclelist=%2",_spawnmarker,_vehiclelist))
CHECK(_spawnmarker isEqualto "")
CHECK(_vehiclelist isEqualto [])
d_log(FORMAT_2("Host=%1 / Caller=%2",_host,_caller))
SETMVAR(DORB_SPAWN_CURRENT,_host);


_spawnpos = getMarkerPos _spawnmarker;
// EMPTY SPAWNPAD
{if (count crew _x == 0) then {deletevehicle _x};} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
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

d_log(FORMAT_1("SEL=%1",_sel))
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