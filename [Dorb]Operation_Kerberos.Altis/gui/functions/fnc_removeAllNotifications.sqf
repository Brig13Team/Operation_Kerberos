/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes all Notifications
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _temp = GVAR(notifications);
GVAR(notifications) = HASH_CREATE;

If !(isNil QGVAR(notification_handlerID)) then {
    [GVAR(notification_handlerID)] call CBA_fnc_removePerFrameHandler;
    GVAR(notification_handlerID) = nil;
};

{
    If (IS_HASH(_x)) then {
        HASH_DELETE(_x);
    };
} forEach (HASH_KEYS(_temp));
HASH_DELETE(_temp);
