/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a notification
 *
 *  Parameter(s):
 *      0 : STRING - ID of the notification
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_id","",[""]]];

HASH_REM(GVAR(notifications),_id);

If (HASH_KEYS(GVAR(notifications)) isEqualTo []) then {
    [GVAR(notification_handlerID)] call CBA_fnc_removePerFrameHandler;
};
