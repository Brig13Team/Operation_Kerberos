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
#define DEBUG_MODE_OFF
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

TRACEV_1(_notifications);

CHECK(_notifications isEqualTo [])

If ((count _notifications) > 6) then {
    _notifications resize 6;
};


{
    //(IDC_NOTIFICATION_1 + _forEachIndex) cutRsc [format[QAPP(notification_%1),_forEachIndex + 1],"PLAIN"];
    (format[QAPP(notification_%1),_forEachIndex + 1]) cutRsc [format[QAPP(notification_%1),_forEachIndex + 1],"PLAIN",0];
    private _display = uiNamespace getvariable [(format[QAPP(notification_%1),_forEachIndex + 1]),displayNull];
    TRACEV_1(_display);
    if (!isNull _display) then {
        private _ctrl = _display displayCtrl IDC_NOTIFICATION_IMG;
        TRACEV_1(_ctrl);
        _ctrl ctrlSetText _x;
        _ctrl ctrlCommit 0;
        TRACEV_1(ctrlText _ctrl);
    };
} forEach _notifications;
