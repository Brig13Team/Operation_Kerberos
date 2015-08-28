/*
    Author: Dorbedo

    Description:
        spawns vehicles.

    Parameter(s):
        0:STRING - Spawnmodus

*/
#include "script_component.hpp"
SCRIPT(spawn_create);
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
If (!(_padempty isEqualTo [])) exitWith {hint localize "STR_DORB_SPAWN_NOTEMPTY";};

private["_flyingpos"];
_flyingpos = getMarkerPos "air_spawn_flying";

CHECK((_vehiclewahl isKindOf "Plane_Base_F")&&(!(_mode isEqualTo "driver"))&&(worldName == "Altis"))
_dist = (_flyingpos distance [0,0,0])>1;

_canNotFly = {
    _return = true;
    If ((typeOf player) in ["B_Pilot_F","B_Helipilot_F"]) then {_return = false;};
    If (GETVAR(player,DORB_ISPILOT,false)) then {_return = false;};
    _return
};

CHECK((_vehiclewahl isKindOf "Air")&&(!(_vehiclewahl isKindOf "UAV"))&&(call _canNotFly))

If (((_flyingpos distance [0,0,0])>1)&&(_vehiclewahl isKindOf "Plane_Base_F")) then {
    _flyingpos set [2,2000];
    _vehiclearray = [_flyingpos, (markerDir "air_spawn_flying"), _vehiclewahl, EGVAR(main,playerside)] call bis_fnc_spawnvehicle;
    _vehicle = _vehiclearray select 0;
}else{
    _vehicle = createVehicle [_vehiclewahl, _spawnpos, [], 0 , "NONE"];
    _vehicle setDir _spawndir;
    if ((_vehicle isKindOf "SDV") or (_vehicle isKindOf "Ship")) then {
        _vehicle setPosASL [getPosASL _vehicle select 0, getPosASL _vehicle select 1, 0];
    } else {
        _vehicle setposatl [_spawnpos select 0, _spawnpos select 1, 0.2];
        _vehicle setVectorUP (surfaceNormal [(getPosatl _vehicle) select 0,(getPosatl _vehicle) select 1]);
    };
};
_vehicle lock 0;
if ( (getText(configFile >> "CfgVehicles" >> _vehiclewahl >> "vehicleClass"))isEqualTo "Autonomous") then {
    createVehicleCrew _vehicle;
};

if ((_vehicle isKindOf "B_Truck_01_medical_F") or (_vehicle isKindOf "B_Slingload_01_Medevac_F") or (_vehicle isKindOf "RHS_UH60M_base") or (_vehicle isKindOf "O_Heli_Transport_04_medevac_F") or (_vehicle isKindOf "rhs_gaz66_ap2_base") or (_vehicle isKindOf "Truck_02_medical_base_F") or (_vehicle isKindOf "O_Truck_03_medical_F")) then {
    SETPVAR(_vehicle,ace_medical_isMedicalFacility,true);
};

if (_mode isEqualTo "driver") then {
    If (((_flyingpos distance [0,0,0])>1)&&(_vehiclewahl isKindOf "Plane_Base_F")&&(!( (getText(configFile >> "CfgVehicles" >> _vehiclewahl >> "vehicleClass"))isEqualTo "Autonomous"))) then {
        {deleteVehicle _x;}forEach (crew _vehicle);
    };
	#ifdef DORB_PILOT_WHITELIST_ENABLED
	If ((isNil "DORB_RESERVED_PILOT_SLOT")&&(_vehicle iskindOf "Air")) exitWith {};
	#endif
    player moveInDriver _vehicle;
};

closeDialog dlg_veh_spawn_idd;