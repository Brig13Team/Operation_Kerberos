/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    If (isNil QGVAR(obj_actionClasses_device)) then {
        GVAR(obj_actionClasses_device) = [];
    };
    If !(_x in GVAR(obj_actionClasses_device)) then {
        GVAR(obj_actionClasses_device) pushback _x;
        private _action = [
            QGVAR(device_disable),
            localize LSTRING(OBJ_DEVICE_DISABLE),
            "",
            LINKFUNC(obj_doDisable),
            LINKFUNC(obj_canDisable)
        ] call ace_interact_menu_fnc_createAction;
        [
            _x,
            0,
            ["ACE_MainActions"],
            _action
        ] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach _this;
