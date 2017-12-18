/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the Symbol of the current Group
 *
 *  Parameter(s):
 *      0 : GROUP - the Group
 *
 *  Returns:
 *      STRING - Type of Symbol
 *
 */
#include "script_component.hpp"

_this params ["_group"];
private _leader = leader _group;
if (!alive _leader) exitWith {"unknown"};
switch (true) do {
    case ((typeOf vehicle _leader) in ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]): {"hq"};
    case ((([typeOf (vehicle _leader),"vehicleClass",""] call EFUNC(common,getCfgVehicles)) == "Autonomous")) : {"uav"};
    case (([typeOf _leader,"vehicleClass",""] call EFUNC(common,getCfgVehicles)) in ["MenSniper","MenRecon"]) : {"recon"};
    case (vehicle _leader isKindOf "Plane") : {"plane"};
    case (vehicle _leader isKindOf "Air") : {"air"};
    case (vehicle _leader isKindOf "Tank") : {"armor"};
    case ((vehicle _leader isKindOf "Wheeled_Apc_F")or(vehicle _leader isKindOf "APC_Tracked_02_base_F")or(vehicle _leader isKindOf "APC_Tracked_03_base_F")) : {"mech_inf"};
    case (([typeOf (vehicle _leader),"engineer",0] call EFUNC(common,getCfgVehicles)) == 1): {"maint"};
    case ((vehicle _leader isKindOf "MBT_01_arty_base_F")or(vehicle _leader isKindOf "MBT_01_mlrs_base_F")) : {"art"};
    case (vehicle _leader isKindOf "Car") : {"motor_inf";};
    case ((vehicle _leader isKindOf "Ship")or(vehicle _leader isKindOf "Submarine")) : {"naval"};
    case (vehicle _leader isKindOf "Man") : {"inf"};
    case (vehicle _leader isKindOf "StaticWeapon") : {"support"};
    default {"unknown"};
};
