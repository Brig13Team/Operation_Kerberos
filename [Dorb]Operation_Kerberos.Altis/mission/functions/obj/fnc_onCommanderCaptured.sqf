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
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_COMMANDER_CAPTURED_MSG_TITLE),
            localize LSTRING(OBJ_COMMANDER_CAPTURED_MSG),
            "green"
        ]
    ] call CBA_fnc_localEvent;
};
