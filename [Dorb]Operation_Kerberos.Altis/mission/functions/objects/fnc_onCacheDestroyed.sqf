/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a cache is destroyed
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
    _this params ["_cache"];
    GVAR(destroyed_caches) = GVAR(destroyed_caches) + 1;
    private _position = getPos _cache;
    "Bo_Mk82" createVehicle _position;
    deleteVehicle _cache;
}else{
    [
        localize LSTRING(WEAPONCACHE_DESTROYED_MSG_TITLE),
        localize LSTRING(WEAPONCACHE_DESTROYED_MSG),
        "green"
    ] call EFUNC(interface,message);
};
