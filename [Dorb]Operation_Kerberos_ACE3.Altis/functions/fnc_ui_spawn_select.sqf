/*
	Author: Dorbedo

	Description:
		Updatedes Pic and Name

	Parameter(s):
		0:SCALAR	- Row

*/
#include "script_component.hpp"
#define dlg_veh_spawn_list_idc 600102
#define dlg_veh_spawn_vehname_idc 600103
#define dlg_veh_spawn_pic_idc 600104
PARAMS_1(_selection);

ctrlSetText[dlg_veh_spawn_vehname_idc,	(lnbData [dlg_veh_spawn_list_idc,[_selection,2] ]) ];
ctrlSetText[dlg_veh_spawn_pic_idc,		(lnbData [dlg_veh_spawn_list_idc,[_selection,3] ]) ];
	