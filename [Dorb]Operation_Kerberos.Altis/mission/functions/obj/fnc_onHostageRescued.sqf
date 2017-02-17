/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Event when a hostage is rescued
 *
 *  Parameter(s):
 *      0 : OBJECT - the missiontarget
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isServer) then {
    _this params ["_hostage"];

    private _mission = _hostage getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter_1", HASH_GET(_mission, "obj_counter_1") + 1);

    deleteVehicle _hostage;
};

If (hasInterface) then {
    _this params ["_hostage"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(HOSTAGE_RESCUED_MSG_TITLE),
            format [localize LSTRING(HOSTAGE_RESCUED_MSG),_caller],
            "green"
        ]
    ] call CBA_fnc_localEvent;
};
