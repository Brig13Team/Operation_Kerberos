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
    QGVAR(addMessage),
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





private _ACE_Action = [
    QGVAR(selfactiongroup),
    localize LSTRING(SELFACTIONGROUP),
    QEPAAPATH(logo,logo_512),
    {[] call FUNC(open);},
    {[] call FUNC(canOpenMenu);}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
