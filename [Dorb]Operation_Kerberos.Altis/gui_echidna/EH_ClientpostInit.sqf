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

private _ACE_Action = [
    QGVAR(selfactiongroup),
    localize LSTRING(SELFACTIONGROUP),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(logo,logo_512),
    LINKFUNC(open),
    LINKFUNC(canOpenMenu)
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
