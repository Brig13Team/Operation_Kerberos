/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the Laptop actions
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

{
    private _action = [
        QGVAR(Laptop_download),
        localize LSTRING(OBJ_LAPTOP_DOWNLOAD),
        "",
        LINKFUNC(obj_doDownload),
        LINKFUNC(obj_canDownload)
    ] call ace_interact_menu_fnc_createAction;

    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;
