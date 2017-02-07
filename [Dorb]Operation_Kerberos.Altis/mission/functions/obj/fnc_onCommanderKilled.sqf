/*
 *  Author: Dorbedo, iJesuz
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

    private _mission = _commander getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter_2", HASH_GET(_mission, "obj_counter_2") + 1);
};

If (hasInterface) then {
    _this params ["_commander","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_COMMANDER_KILLED_MSG_TITLE),
            format [localize LSTRING(OBJ_COMMANDER_KILLED_MSG),name _commander],
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
