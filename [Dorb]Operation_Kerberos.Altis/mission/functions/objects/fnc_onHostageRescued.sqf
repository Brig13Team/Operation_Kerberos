/*
 *  Author: Dorbedo
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

If (isHeadless) exitWith {};
If (isServer) then {
    _this params ["_hostage"];
    GVAR(rescued_hostages) = GVAR(rescued_hostages) + 1;
    deleteVehicle _hostage;
}else{
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
