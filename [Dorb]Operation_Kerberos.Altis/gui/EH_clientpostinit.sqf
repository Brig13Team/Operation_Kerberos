/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)

QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(timer)};
[] spawn FUNC(timer);

[QGVAR(message),{_this spawn FUNC(message)}] call CBA_fnc_addEventHandler;


private _ACE_Action = [
    QGVAR(selfactiongroup),
    localize LSTRING(SELFACTIONGROUP),
    QEPAAPATH(logo,logo_512),
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

[ACE_Player, 1, ["ACE_SelfActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
