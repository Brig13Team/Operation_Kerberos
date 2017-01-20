/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a prototype is rescued
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
    GVAR(rescued_prototype) = GVAR(rescued_prototype) + 1;
    deleteVehicle _prototype;
}else{
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(NEW_PROTOTYPE_RESCUED_MSG_TITLE),
            localize LSTRING(NEW_PROTOTYPE_RESCUED_MSG),
            "green"
        ]
    ] call CBA_fnc_localEvent;
};
