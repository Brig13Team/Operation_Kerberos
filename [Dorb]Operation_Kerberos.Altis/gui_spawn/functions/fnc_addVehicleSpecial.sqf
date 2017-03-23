/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_object",objNull,[objNull]]];


CHECK(isNull _object);

switch (typeOf _object) do {
    case "B_Truck_01_medical_F";
    case "B_Slingload_01_Medevac_F";
    case "RHS_UH60M_base";
    case "O_Heli_Transport_04_medevac_F";
    case "rhs_gaz66_ap2_base";
    case "Truck_02_medical_base_F";
    case "O_Truck_03_medical_F" : {
        _vehicle setVariable ["ace_medical_isMedicalFacility",true];
    };
};
