/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    If (isNil QGVAR(intel_init_security)) then {
        GVAR(intel_init_security) = [];
    };
    If !(_x in GVAR(intel_init_security)) then {
        GVAR(intel_init_security) pushback _x;
        private _action = [
            QGVAR(intel_take),
            localize LSTRING(OBJECTS_INTEL_GRAB),
            "",
            {
                [QGVAR(intel_found),[_target,profileName]] call CBA_fnc_globalEvent;
            },
            {true}
        ] call ace_interact_menu_fnc_createAction;
        [
            _x,
            0,
            ["ACE_MainActions"],
            _action
        ] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach _this;
