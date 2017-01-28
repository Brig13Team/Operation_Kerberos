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
    _this params ["_cache"];
    GVAR(commander_killed) = GVAR(commander_killed) + 1;
};
If (hasInterface) then {
    _this params ["_cache","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(WEAPONCACHE_DESTROYED_MSG_TITLE),
            localize LSTRING(WEAPONCACHE_DESTROYED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
