/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Post Init Header
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

[
    QGVAR("addMessage"),
    {_this call FUNC(addMessage);}
] call CBA_fnc_addEventHandler;

[
    "", /// add a receiving status (WLAN symbol?)
    {GVAR(canOpenApps)}
] call FUNC(addNotification);
[
    "", /// new notification picture
    {GVAR(newMessage)}
] call FUNC(addNotification);
