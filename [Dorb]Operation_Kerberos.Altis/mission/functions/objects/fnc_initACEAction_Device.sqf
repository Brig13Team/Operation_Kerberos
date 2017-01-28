/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    If (isNil QGVAR(intel_device_security)) then {
        GVAR(intel_device_security) = [];
    };
    If !(_x in GVAR(intel_device_security)) then {
        GVAR(intel_device_security) pushback _x;
        private _action = [
            QGVAR(device_disable),
            localize LSTRING(OBJECTS_DEVICE_DISABLE),
            "",
            {
                _target call FUNC(objects_device_doDisable)
            },
            {
                _target call FUNC(objects_device_canDisable)
            }
        ] call ace_interact_menu_fnc_createAction;
        [
            _x,
            0,
            ["ACE_MainActions"],
            _action
        ] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach _this;
