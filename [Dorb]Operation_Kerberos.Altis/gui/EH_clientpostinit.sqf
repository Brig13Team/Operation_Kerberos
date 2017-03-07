/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)

// notification
uiNamespace setVariable [QGVAR(lastNotificationHandle),CBA_missiontime];

[QGVAR(message),{
    If (IS_ARRAY(_this select 1)) then {
        _thisCopy =+ _this;
        _thisCopy set[1,(_thisCopy select 1) joinString "<br />"];
        _thisCopy spawn FUNC(message);
    }else{
        _this spawn FUNC(message);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(showTimer),{
    If ((!(isNil QGVAR(timer_finish)))&&{isNil QGVAR(timer_handle)}) then {
        GVAR(timer_handle) = [LINKFUNC(handleTimer),10,[]] call CBA_fnc_addPerFrameHandler;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(showTimer)] call CBA_fnc_localEvent;
