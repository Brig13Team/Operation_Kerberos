/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for device
 *      (it's called once from clientPostInit)
 *
 *  Parameter(s):
 *      0 : [STRING]    - device classes
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

{
    private _action = [
        QGVAR(disableDevice),
        localize LSTRING(OBJ_DEVICE_DISABLE),
        "",
        { [_target, { (_this select 0) call FUNC(obj__increaseCounter); }, LSTRING(OBJ_DEVICE_DEACTIVATING)] call FUNC(obj__progressBar); },
        { (_this select 0) getVariable [QGVAR(isActive), false]; }
    ] call ace_interact_menu_fnc_createAction;

    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;
