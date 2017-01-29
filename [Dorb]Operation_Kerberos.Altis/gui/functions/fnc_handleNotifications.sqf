/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handles the notifications
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;
private _notifications = [];

{
    private _hash = HASH_GET(GVAR(notifications),_x);
    If (HASH_GET_DEF(_hash,"parameter",[]) call HASH_GET(_hash,"condition")) then {
        _notifications pushBack HASH_GET(_hash,"img");
    };
} forEach HASH_KEYS(GVAR(notifications));

CHECK(_notifications isEqualTo [])

If ((count _notifications) > 5) then {
    _notifications resize 5;
};


{
    (IDC_NOTIFICATION + _forEachIndex) cutRsc [format[QAPP(notification_%1),_forEachIndex],"PLAIN"];
    private _display = uiNamespace getvariable QAPP(notification_%1);
    if (!isNull _display) then {
        private _ctrl = _display displayCtrl IDC_NOTIFICATION_IMG;
        _ctrl ctrlSetText _x;
    };
} forEach _notifications;
