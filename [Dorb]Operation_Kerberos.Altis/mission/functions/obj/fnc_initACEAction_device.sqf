/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    private _action = [
        QGVAR(device_disable),
        localize LSTRING(OBJ_DEVICE_DISABLE),
        "",
        { [_this select 0] call FUNC(obj_disableDevice); },
        LINKFUNC(obj_canDisable)
    ] call ace_interact_menu_fnc_createAction;

    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;
