/*
	Author: Dorbedo

	Description:
		Updatedes Pic and Name

	Parameter(s):
		1:SCALAR	- Row

*/
#include "script_component.hpp"
#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_list_idc 600102
#define dlg_veh_spawn_vehname_idc 600103
#define dlg_veh_spawn_pic_idc 600104
disableSerialization;
private ["_selection","_ctrlList","_ctrlname","_ctrlpic","_pic","_name"];

_selection = _this select 1;

_ctrlname = findDisplay dlg_veh_spawn_idd displayCtrl dlg_veh_spawn_vehname_idc;
_ctrlpic = findDisplay dlg_veh_spawn_idd displayCtrl dlg_veh_spawn_pic_idc;
_ctrlList = findDisplay dlg_veh_spawn_idd displayCtrl dlg_veh_spawn_list_idc;


_name = _ctrlList lnbData [_selection,2];
_pic = _ctrlList lnbData [_selection,3];

_ctrlname ctrlSetText _name;
_ctrlpic ctrlSetText _pic;