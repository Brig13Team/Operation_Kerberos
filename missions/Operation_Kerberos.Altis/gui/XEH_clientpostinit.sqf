/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)

// notification
uiNamespace setVariable [QGVAR(lastNotificationHandle),CBA_missiontime];

/*
[QGVAR(message),{
    If (IS_ARRAY(_this select 1)) then {
        _thisCopy =+ _this;
        _thisCopy set[1,(_thisCopy select 1) joinString "<br />"];
        _thisCopy spawn FUNC(message);
    }else{
        _this spawn FUNC(message);
    };
}] call CBA_fnc_addEventHandler;
*/

[localize ELSTRING(main,name), QGVAR(showTimer), localize LSTRING(showTimer), {
    if !([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ace_common_fnc_canInteractWith) exitWith {false};
    if (!(missionNamespace getVariable [QGVAR(timerIsShown), false])) then {
        call FUNC(showTimer);
    } else {
        call FUNC(hideTimer);
    };
    true
}, {false}, [24, [false, false, false]], false] call CBA_fnc_addKeybind;

