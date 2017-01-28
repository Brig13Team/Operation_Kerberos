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

If (isServer) then {
    _this params ["_commander"];
    GVAR(commander_captured) = GVAR(commander_captured) + 1;
    deleteVehicle _commander;
};
If (hasInterface) then {
    _this params ["_hostage"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(COMMANDER_RESCUED_MSG_TITLE),
            format [localize LSTRING(COMMANDER_RESCUED_MSG),_caller],
            "green"
        ]
    ] call CBA_fnc_localEvent;
};
