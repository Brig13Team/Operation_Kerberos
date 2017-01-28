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

If (isHeadless) exitWith {};
If (isServer) then {
    _this params ["_prototype"];
    GVAR(killed_prototype) = GVAR(killed_prototype) + 1;
}else{
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(PROTOTYPE_KILLED_MSG_TITLE),
            localize LSTRING(PROTOTYPE_KILLED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
