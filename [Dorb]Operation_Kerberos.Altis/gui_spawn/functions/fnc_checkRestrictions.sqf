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
 *      BOOL - true if the player is not allowed to spawn
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_player","_vehicleType"];

private _return = false;
private _vclass = getText(configFile >> "CfgVehicles" >> _vehicleType >> "vehicleClass");

if (
    (_vclass in ["rhs_vehclass_ifv","rhs_vehclass_tank","rhs_vehclass_artillery","Armored",
                 "BWA3_VehClass_Tracked_Tropen","BWA3_VehClass_Tracked_Fleck","BWA3_VehClass_Wheeled_Tropen",
                 "BWA3_VehClass_Wheeled_Fleck"])
     && {typeOf player != "B_Crew_F"} &&{missionNamespace getVariable [QEGVAR(player,whitelistenabled),false]}
     ) then {
         _return = true;
     };

If ((_vehicleType isKindOf "Air")&&{!(_vehiclewahl isKindOf "UAV")}) then {
    If (!(
        (((typeOf _player) in ["B_Pilot_F","B_Helipilot_F"])||(_player getVariable [QGVARMAIN(ISPILOT),false]))&&
        (missionNamespace getVariable [QEGVAR(player,whitelistenabled),false])
    )) then {
        _return = true;
    };
};

_return;
