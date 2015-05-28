/*
	Author: Dorbedo

	Description:
	Updatedes Pic and Name

	Parameter(s):
		
		TO DO

*/
#include "makros.hpp"
private["_selection"];
#define dlg_veh_spawn_list_idc 600102
#define dlg_veh_spawn_vehname_idc 600103
#define dlg_veh_spawn_pic_idc 600104

_selection = _this select 1;
ctrlSetText[dlg_veh_spawn_vehname_idc,	(lnbData [dlg_veh_spawn_list_idc,[_selection,2] ]) ];
ctrlSetText[dlg_veh_spawn_pic_idc,		(lnbData [dlg_veh_spawn_list_idc,[_selection,3] ]) ];
	