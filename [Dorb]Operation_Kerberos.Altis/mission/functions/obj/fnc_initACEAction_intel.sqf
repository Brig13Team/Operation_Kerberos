/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for intel objects
 *      (it's called once from clientPostInit)
 *
 *  Parameter(s):
 *      0 : [STRING]    - device classes
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

#include "script_component.hpp"

{
    private _action = [
        QGVAR(takeIntel),
        localize LSTRING(OBJ_INTEL_GRAB),
        "",
        { [_target] call FUNC(obj__increaseCounter); deleteVehicle _target; },
        { true }
    ] call ace_interact_menu_fnc_createAction;

    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;
