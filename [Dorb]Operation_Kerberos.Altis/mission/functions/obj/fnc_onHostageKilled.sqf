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
    _this params ["_hostage"];
    GVAR(killed_hostages) = GVAR(killed_hostages) + 1;
};
If (hasInterface) then {
    _this params ["_hostage","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_HOSTAGE_KILLED_MSG_TITLE),
            format[localize LSTRING(OBJ_HOSTAGE_KILLED_MSG),_killer],
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
