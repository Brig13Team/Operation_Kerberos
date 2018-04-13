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
CHECK(isNull _object);

If (!(local _vehicle)) exitWith {[QGVAR(addVehicleSpecial),[_vehicle],_vehicle] call CBA_fnc_targetEvent;};

switch (true) do {
    case ((typeOf _object) in ["B_Truck_01_medical_F","B_Slingload_01_Medevac_F","O_Heli_Transport_04_medevac_F","Truck_02_medical_base_F","O_Truck_03_medical_F"]);
    case (_object isKindOf "rhsusf_M1230a1_usarmy_wd");
    case (_object isKindOf "rhsusf_M1230a1_usarmy_d");
    case (_object isKindOf "RHS_UH60M_base");
    case (_object isKindOf "rhs_gaz66_ap2_base");
    case ([_object] call ace_medical_fnc_isMedicalVehicle) : {
        If !(isNil QEFUNC(mod_ace,addMedicalItems)) then {
            [_vehicle] call EFUNC(mod_ace,addMedicalItems);
        };
    };
    case ((typeOf _object) isKindOf "Land_DataTerminal_01_F") : {
        [QEGVAR(mission,MakeDataTerminalDraggable),[_object]] call CBA_fnc_globalEvent;
    };
};

if (((side ace_player) == west)&&{(typeOf _object) in ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"]}) then {
    [_object,"blufor",true] call BIS_fnc_initVehicle;
};

if (((side ace_player) == west)&&{(typeOf _object) in ["I_LT_01_AT_F","I_LT_01_scout_F","I_LT_01_AA_F","I_LT_01_cannon_F"]}) then {
    [_object,"Indep_Olive",true] call BIS_fnc_initVehicle;
};
