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
    GVAR(killed_hostages) = GVAR(killed_hostages) + 1;
}else{
    _this params ["_hostage","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(HOSTAGE_KILLED_MSG_TITLE),
            localize LSTRING(HOSTAGE_KILLED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
