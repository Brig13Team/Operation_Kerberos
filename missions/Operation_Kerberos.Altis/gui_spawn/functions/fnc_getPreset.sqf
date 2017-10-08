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
    case "carrier_marine";
    case "boat" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Ship_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
        _return append ["C_Boat_Transport_02_F"];
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
        switch _sideNumber do {
            case 0 : {_return append ["Box_East_AmmoVeh_F"];};
            case 2 : {_return append ["Box_IND_AmmoVeh_F"];};
            default {_return append ["Box_NATO_AmmoVeh_F"];}
        };
        _return arrayIntersect _return;
    };
    case "carrier_air" : {
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Air')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Autonomous'})",_sideNumber], true]);
        _return = _return apply {configName _x};
        _return = _return select {!(_x in ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F"])};
        _return arrayIntersect _return;
    };
    case "carrier_vehicles" : {
        // vehicles
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{(configName _x) isKindOf 'Slingload_01_Base_F'})", true]);
        _return = _return apply {configName _x};
        _return pushBack "Box_NATO_AmmoVeh_F";
        _return pushBack "B_Quadbike_01_F";
        _return pushBack "B_APC_Tracked_01_CRV_F";
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        // remove doubled
        _return arrayIntersect _return;
    };
    case "carrier_landingbay_vehicles" : {
        // vehicles
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'LandVehicle')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')}&&{!(getText(_x>>'vehicleClass')=='Static')})",_sideNumber], true])
        // cars
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{(configName _x) isKindOf 'Slingload_01_Base_F'})", true])
        // static units
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true]);
        // ground drones
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{(configName _x) isKindOf 'UGV_01_base_F'})",_sideNumber], true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        If (GVARMAIN(playerside) == west) then {
            _return append ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"];
        };
        _return pushBack "Land_DataTerminal_01_F";
        _return pushBack "Box_NATO_AmmoVeh_F";
        // remove doubled
        _return arrayIntersect _return;
    };
    case "planes" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'plane')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "helicopter" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==%1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'helicopter')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };


    case "boat_guerilla" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Ship_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
        _return append ["C_Boat_Transport_02_F"];
    };
    case "drones_guerilla" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Autonomous'})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "air_guerilla" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Air')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "vehicles_guerilla" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'LandVehicle')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')}&&{!(getText(_x>>'vehicleClass')=='Static')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "logistic_guerilla" : {
        // static units
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // cars
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})",_sideNumber], true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_IND_AmmoVeh_F"];
        _return arrayIntersect _return;
    };
    case "boat_east" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Ship_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
        _return append ["C_Boat_Transport_02_F"];
    };
    case "drones_east" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Autonomous'})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "air_east" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Air')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "vehicles_east" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'LandVehicle')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')}&&{!(getText(_x>>'vehicleClass')=='Static')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "logistic_east" : {
        // static units
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // cars
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})",_sideNumber], true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_East_AmmoVeh_F"];
        _return arrayIntersect _return;
    };
     case "boat_west" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Ship_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
        _return append ["C_Boat_Transport_02_F"];
    };
    case "drones_west" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{getText(_x>>'vehicleClass')=='Autonomous'})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "air_west" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Air')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true];
        _return = _return apply {configName _x};
    };
    case "vehicles_west" : {
        _return = configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'LandVehicle')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')}&&{!(getText(_x>>'vehicleClass')=='Static')})",_sideNumber], true];
        _return = _return apply {configName _x};
        _return append ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"];
    };
    case "logistic_west" : {
        // static units
        _return = (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // cars
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})",_sideNumber], true])
        // slingload
        + (configProperties [configfile>>"CfgVehicles",format ["((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})",_sideNumber], true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_NATO_AmmoVeh_F"];
        _return arrayIntersect _return;
    };

    default {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Air')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        #ifdef DEBUG_MODE_FULL
            _return pushBack "Land_VR_Block_05_F";
        #endif
    };
};
// forced blacklist
_return select {!((toLower _x) in ["rhs_9k79_b"])};
