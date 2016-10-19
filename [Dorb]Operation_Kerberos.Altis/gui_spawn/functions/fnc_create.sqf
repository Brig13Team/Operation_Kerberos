/*
    Author: Dorbedo

    Description:
        spawns vehicles.

    Parameter(s):
        0:STRING - Spawnmodus

*/
#define INCLUDE_GUI
#include "script_component.hpp"

_this params[["_mode","",[""]]];

disableSerialization;
private _selection = lnbCurSelRow IDC_SPAWN_DLG_LIST;
private _vehiclewahl = lnbData [IDC_SPAWN_DLG_LIST,[_selection,0] ];
CHECK(_vehiclewahl isEqualTo "")

private _spawn = GETMVAR(GVAR(current),"");
//CHECK(IS_OBJECT(_spawn))

private _spawnpoint = GETVAR(_spawn,GVAR(point),"");
private _spawnpos = markerPos _spawnpoint;
private _spawndir = markerDir _spawnpoint;

private _padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], CHECK_RADIUS];
If (!(_padempty isEqualTo [])) exitWith {hint localize LSTRING(NOTEMPTY);};

private _flyingpos = getMarkerPos "air_flying";

CHECK((_vehiclewahl isKindOf "Plane_Base_F")&&(!(_mode isEqualTo "driver"))&&(worldName == "Altis"))
private _dist = (_flyingpos distance [0,0,0])>1;

private _canNotFly = {
    _return = true;
    If ((typeOf player) in ["B_Pilot_F","B_Helipilot_F"]) then {_return = false;};
    If (GETVAR(player,GVARMAIN(ISPILOT),false)) then {_return = false;};
    _return
};

private _vclass = getText(configFile >> "CfgVehicles" >> _vehiclewahl >> "vehicleClass");
CHECK((_vehiclewahl isKindOf "Air")&&(!(_vehiclewahl isKindOf "UAV"))&&(call _canNotFly))
if((_vclass in ["rhs_vehclass_ifv","rhs_vehclass_tank","rhs_vehclass_artillery","Armored","BWA3_VehClass_Tracked_Tropen","BWA3_VehClass_Tracked_Fleck","BWA3_VehClass_Wheeled_Tropen","BWA3_VehClass_Wheeled_Fleck"]) && {typeOf player != "B_Crew_F"}) exitWith {};

private "_vehicle";

If (((_flyingpos distance [0,0,0])>1)&&(_vehiclewahl isKindOf "Plane_Base_F")) then {
    _flyingpos set [2,2000];
    private _vehiclearray = [_flyingpos, (markerDir "air_spawn_flying"), _vehiclewahl, GVARMAIN(playerside) ] call bis_fnc_spawnvehicle;
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
    If (isNumber(configFile >> "CfgVehicles" >> _vehiclewahl >> "ace_fastroping_enabled")) then {
        [_vehicle] call ace_fastroping_fnc_equipFRIES;
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
    If ((isNil QEGVAR(main,reserved_pilot_slot))&&ISCASVEHICLE_C(_vehiclewahl)) exitWith {};
    #endif
    player moveInDriver _vehicle;
};

If (ACTIVEMOD_TFAR) then {
    _vehicle setVariable ["tf_side", GVARMAIN(playerSide), true];
};

["VEHICLE_SPAWNED",[_vehicle]] spawn CBA_fnc_serverEvent;

closeDialog IDD_SPAWN_DLG;
