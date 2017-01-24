/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)

QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(timer)};
[] spawn FUNC(timer);

[QGVAR(message),
{
    If (IS_ARRAY(_this select 1)) then {
        _thisCopy =+ _this;
        _thisCopy set[1,(_thisCopy select 1) joinString "<br />"];
        _thisCopy spawn FUNC(message);
    }else{
        _this spawn FUNC(message);
    };
}] call CBA_fnc_addEventHandler;
