/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    If (isNil QGVAR(obj_actionClasses_intel)) then {
        GVAR(obj_actionClasses_intel) = [];
    };
    If !(_x in GVAR(obj_actionClasses_intel)) then {
        GVAR(obj_actionClasses_intel) pushback _x;
        private _action = [
            QGVAR(obj_takeIntel),
            localize LSTRING(OBJ_INTEL_GRAB),
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
