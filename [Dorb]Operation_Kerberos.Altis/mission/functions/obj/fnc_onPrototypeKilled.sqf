/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a prototype is destroyed
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
    _this params ["_prototype"];
    GVAR(killed_prototype) = GVAR(killed_prototype) + 1;
};

If (hasInterface) then {
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_PROTOTYPE_KILLED_MSG_TITLE),
            localize LSTRING(OBJ_PROTOTYPE_KILLED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
