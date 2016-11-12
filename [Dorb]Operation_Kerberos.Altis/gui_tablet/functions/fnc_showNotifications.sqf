/*
 *  Author: DOrbedo
 *
 *  Description:
 *      shows the notifications
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

private _allNotifications = HASH_KEYS(GVAR(notifications));

_allNotifications = _allNotifications select { ( [] call (_x select 1) ) };

private _string = "";
private _max = 6 min (count _allNotifications - 1);

for "_i" from 0 to _max do {
    _string = _string + format[" <img image='%1' />",(_allNotifications select _i)];
};

private _ctrl = (findDisplay IDD_TABLET_MAIN) displayCtrl IDC_TABLET_TOPBAR_NOTIFICATIONS;
_ctrl ctrlSetStructuredText text _string;
