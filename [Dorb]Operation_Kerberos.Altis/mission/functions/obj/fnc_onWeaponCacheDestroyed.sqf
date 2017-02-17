/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Event when a weaponcache is destroyed
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
    _this params ["_obj"];

    private _mission = _obj getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
};

If (hasInterface) then {
    _this params ["_cache","_killer"];
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_WEAPONCACHE_DESTROYED_MSG_TITLE),
            localize LSTRING(OBJ_WEAPONCACHE_DESTROYED_MSG),
            "red"
        ]
    ] call CBA_fnc_localEvent;
};
