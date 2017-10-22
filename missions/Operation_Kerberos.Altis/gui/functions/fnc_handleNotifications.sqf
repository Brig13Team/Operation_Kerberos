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

If ((!(_notifications isEqualTo []))||{({(!(_x isEqualTo [0,0,0]))&&{(player distance _x)<200}} count [getMarkerPos GVARMAIN(respawnmarker),getMarkerPos "respawn_west_land"])>0}) then {
    uiNamespace setVariable [QGVAR(lastNotificationHandle),diag_tickTime];
    TRACEV_2(_x select 1,_delay);
    If (_delay > 1) then {
        _x set [1,0.5];
    };
};

If (_notifications isEqualTo []) exitWith {
    private _display = uiNamespace getvariable [QAPP(notification_1),displayNull];
    if (!isNull _display) then {
        for "_i" from 1 to 6 do {
            (format[QAPP(notification_%1),_i]) cutText ["","PLAIN",0];
        };
    };
    // faster notification update, if you are near by modifing the PFH
    if ((_delay < NOTIFICATION_SHOW_DELAY)&&{(uiNamespace getVariable [QGVAR(lastNotificationHandle),diag_tickTime])<diag_tickTime}) then {
        _x set [1,NOTIFICATION_SHOW_DELAY];
    };
};

// resize the amount of notifications

If ((count _notifications) > 6) then {
    _notifications resize 6;
};

private _index = 1;
{
    //(IDC_NOTIFICATION_1 + _forEachIndex) cutRsc [format[QAPP(notification_%1),_forEachIndex + 1],"PLAIN"];
    (format[QAPP(notification_%1),_forEachIndex + 1]) cutRsc [format[QAPP(notification_%1),_forEachIndex + 1],"PLAIN",0];
    private _display = uiNamespace getvariable [(format[QAPP(notification_%1),_forEachIndex + 1]),displayNull];
    if (!isNull _display) then {
        private _ctrl = _display displayCtrl IDC_NOTIFICATION_IMG;
        _ctrl ctrlSetText _x;
        _ctrl ctrlCommit 0;
    };
    _index = _forEachIndex;
} forEach _notifications;
TRACEV_2(_index,_notifications);
for "_i" from (_index+2) to 6 do {
    (format[QAPP(notification_%1),_i]) cutText ["","PLAIN",0];
};
