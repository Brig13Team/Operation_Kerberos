/*
    Author: Dorbedo

    Description:
        spawns vehicles.

    Parameter(s):
        0:STRING - Spawnmodus

*/
#include "script_component.hpp"
SCRIPT(create);
#define dlg_veh_spawn_idd 600100
#define dlg_veh_spawn_list_idc 600102
params[["_mode","",[""]]];
Private["_check_radius","_selection","_vehiclewahl","_vehicle","_spawn","_spawnpoint","_spawndir","_spawnpos","_padempty"];
_check_radius = 10;
disableSerialization;
_selection = lnbCurSelRow dlg_veh_spawn_list_idc;
_vehiclewahl = lnbData [dlg_veh_spawn_list_idc,[_selection,0] ];
CHECK(_vehiclewahl isEqualTo "")

_spawn = GETMVAR(GVAR(spawn_current),"");
//CHECK(IS_OBJECT(_spawn))

_spawnpoint = GETVAR(_spawn,GVAR(spawn_point),"");
_spawnpos = markerPos _spawnpoint;
_spawndir = markerDir _spawnpoint;

_padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];
If (!(_padempty isEqualTo [])) exitWith {hint localize LSTRING(NOTEMPTY);};



_canNotFly = {
    _return = true;
    If ((typeOf player) in ["B_Pilot_F","B_Helipilot_F"]) then {_return = false;};
    If (GETVAR(player,GVARMAIN(ISPILOT),false)) then {_return = false;};
    _return
};

private["_vlclass"];
_vclass = getText(configFile >> "CfgVehicles" >> _vehiclewahl >> "vehicleClass");
CHECK((_vehiclewahl isKindOf "Air")&&(!(_vehiclewahl isKindOf "UAV"))&&(call _canNotFly))
if((_vclass in ["rhs_vehclass_ifv","rhs_vehclass_tank","rhs_vehclass_artillery","Armored","BWA3_VehClass_Tracked_Tropen","BWA3_VehClass_Tracked_Fleck","BWA3_VehClass_Wheeled_Tropen","BWA3_VehClass_Wheeled_Fleck"]) && {typeOf player != "B_Crew_F"}) exitWith {};


_vehicle = createVehicle [_vehiclewahl, _spawnpos, [], 0 , "NONE"];
_vehicle setDir _spawndir;
if ((_vehicle isKindOf "SDV") or (_vehicle isKindOf "Ship")) then {
	_vehicle setPosASL [getPosASL _vehicle select 0, getPosASL _vehicle select 1, 0];
} else {
	_vehicle setposatl [_spawnpos select 0, _spawnpos select 1, 0.2];
	_vehicle setVectorUP (surfaceNormal [(getPosatl _vehicle) select 0,(getPosatl _vehicle) select 1]);
};
If (_vehicle isKindOf "Air") then {
	[_vehicle] call ace_fastroping_fnc_equipFRIES;
};

_vehicle lock 0;
if ( (getText(configFile >> "CfgVehicles" >> _vehiclewahl >> "vehicleClass"))isEqualTo "Autonomous") then {
    createVehicleCrew _vehicle;
};

if ((_vehicle isKindOf "B_Truck_01_medical_F") or (_vehicle isKindOf "B_Slingload_01_Medevac_F") or (_vehicle isKindOf "RHS_UH60M_base") or (_vehicle isKindOf "O_Heli_Transport_04_medevac_F") or (_vehicle isKindOf "rhs_gaz66_ap2_base") or (_vehicle isKindOf "Truck_02_medical_base_F") or (_vehicle isKindOf "O_Truck_03_medical_F")) then {
    SETPVAR(_vehicle,ace_medical_isMedicalFacility,true);
};

if (_vehiclewahl in ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"]) then {
    [_vehicle,"blufor",true] call BIS_fnc_initVehicle;
};

if (_vehiclewahl in ["O_Heli_Transport_04_F"]) then {
    [_vehicle,"Black",["AddCargoHook_COver",0]] call BIS_fnc_initVehicle;
};


if (_mode isEqualTo "driver") then {
	#ifdef DORB_PILOT_WHITELIST_ENABLED
	If ((isNil QEGVAR(main,reserved_pilot_slot))&&ISCASVEHICLE_C(_vehiclewahl)) exitWith {};
	#endif
    player moveInDriver _vehicle;
};

closeDialog dlg_veh_spawn_idd;