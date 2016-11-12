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
