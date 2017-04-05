/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a preset by a string
 *
 *  Parameter(s):
 *      0 : STRING - preset name
 *
 *  Returns:
 *      ARRAY - Array of classnames
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_preset","",[""]]];
private _return = [];

private _sideNumber = switch (GVARMAIN(playerside)) do {
    case resistance : {2};
    case civilian : {3};
    case east : {0};
    default {1};
};
TRACEV_1(_preset);
switch (_preset) do {

    case "air_light" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'helicopter')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return select {"transport" in (getArray(_x >> 'availableForSupportTypes') apply {toLower _x})};
        _return = _return apply {configName _x};
        _return = _return select {!(ISCASVEHICLE(_x))};
    };
    case "boat" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Ship_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "drones" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Autonomous'})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "air" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Air')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "vehicles" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'LandVehicle')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')}&&{!(getText(_x>>'vehicleClass')=='Static')})",_sideNumber], true];
        _return = _return apply {configName _x};
        If (GVARMAIN(playerside) == west) then {
            _return append ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"];
        };
    };
    case "logistic" : {
        // static units
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // cars
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})",_sideNumber], true]);

        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
    };


    default {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Air')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        TRACEV_1(_return);
        _return pushBack "Land_VR_Block_05_F";
    };
};
_return;
