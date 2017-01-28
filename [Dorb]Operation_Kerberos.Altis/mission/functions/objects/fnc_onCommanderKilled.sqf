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
    GVAR(commander_killed) = GVAR(commander_killed) + 1;
};
If (hasInterface) then {
    _this params ["_hostage","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(COMMANDER_KILLED_MSG_TITLE),
            localize LSTRING(COMMANDER_KILLED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
