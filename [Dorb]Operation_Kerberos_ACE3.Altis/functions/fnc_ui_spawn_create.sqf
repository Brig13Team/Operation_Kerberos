/*
	Author: Dorbedo

	Description:
	spawns vehicles.

	Parameter(s):
		
		TO DO

*/
#include "script_component.hpp"

#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_list_idc 600102
DEFAULT_PARAM(0,_mode,"");
_check_radius = 10;
disableSerialization;
_selection = lnbCurSelRow dlg_veh_spawn_list_idc;
_vehiclewahl = lnbData [dlg_veh_spawn_list_idc,[_selection,0] ];
CHECK(_vehiclewahl isEqualTo "")

_spawn = GETMVAR(DORB_SPAWN_CURRENT,"");
//CHECK(IS_OBJECT(_spawn))

_spawnpoint = GETVAR(_spawn,DORB_SPAWNPOINT,"");
_spawnpos = markerPos _spawnpoint;
_spawndir = markerDir _spawnpoint;

_padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];
If (!(_padempty isEqualTo [])) exitWith {hint localize "STR_DORB_SPAWN_NOTEMPTY";};


_vehicle = createVehicle [_vehiclewahl, _spawnpos, [], 0 , "NONE"];
_vehicle setDir _spawndir;

if ((_vehicle isKindOf "SDV") or (_vehicle isKindOf "Ship")) then {
	_vehicle setPosASL [getPosASL _vehicle select 0, getPosASL _vehicle select 1, 0];
} else {
	_vehicle setposatl [_spawnpos select 0, _spawnpos select 1, 0.2];
	_vehicle setVectorUP (surfaceNormal [(getPosatl _vehicle) select 0,(getPosatl _vehicle) select 1]);
};

if ((_vehicle isKindOf "UAV_01_base_F")||(_vehicle isKindOf "UAV_02_base_F")||(_vehicle isKindOf "UGV_01_base_F")) then {
	createVehicleCrew _vehicle;
};

if (_vehicle isKindOf "Air") then {
	_vehicle call FM(nurpiloten);
};

if ((_vehicle isKindOf "B_Truck_01_medical_F") or (_vehicle isKindOf "B_Slingload_01_Medevac_F") or (_vehicle isKindOf "RHS_UH60M_base") or (_vehicle isKindOf "O_Heli_Transport_04_medevac_F")) then {
	SETPVAR(_vehicle,ace_medical_isMedicalFacility,true);
};

if (_mode isEqualTo "driver") then {
	if (_vehicle iskindOf "Air" AND !((typeOf player) in ["B_Pilot_F","B_Helipilot_F"])) exitWith {};
	player moveInDriver _vehicle;
};

closeDialog dlg_veh_spawn_idd;