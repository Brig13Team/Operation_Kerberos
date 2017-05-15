/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Function to add vehicle specific features
 *
 *  Parameter(s):
 *      0 : OBJECT - the vehicle
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_object",objNull,[objNull]]];
TRACEV_1(_vehicle);

CHECK(isNull _object);

switch (typeOf _object) do {
    case "B_Truck_01_medical_F";
    case "B_Slingload_01_Medevac_F";
    case "RHS_UH60M_base";
    case "O_Heli_Transport_04_medevac_F";
    case "rhs_gaz66_ap2_base";
    case "Truck_02_medical_base_F";
    case "O_Truck_03_medical_F" : {
        If !(isNil QEFUNC(mod_ace,addMedicalItems)) then {
            [_vehicle] call EFUNC(mod_ace,addMedicalItems);
        };
        _vehicle setVariable ["ace_medical_isMedicalFacility",true];
    };
    case "Land_DataTerminal_01_F" : {
        [_vehicle, true,[1,0,0],90] call ace_dragging_fnc_setDraggable;
    };
};

if ((GVARMAIN(playerside) == west)&&{(typeOf _object) in ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"]}) then {
    [_object,"blufor",true] call BIS_fnc_initVehicle;
};
