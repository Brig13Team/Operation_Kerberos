/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the Data-Terminal actions
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

params ["_classes"];

{
    private _action = [
        QGVAR(dataTerminal_activate),
        localize LSTRING(DATATERMINAL_ACTIVATE),
        "",
        {
            [_target, 3] call BIS_fnc_DataTerminalAnimate;
        },
        {
            (_target animationSourcePhase "Antenna_source")==0;
        }
    ] call ace_interact_menu_fnc_createAction;
    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;

    private _action = [
        QGVAR(dataTerminal_deactivate),
        localize LSTRING(DATATERMINAL_DEACTIVATE),
        "",
        {
            [_target, 0] call BIS_fnc_DataTerminalAnimate;
        },
        {
            (_target animationSourcePhase "Antenna_source")>=3
        }
    ] call ace_interact_menu_fnc_createAction;
    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;

    private _action = [
        QGVAR(dataTerminal_download),
        localize LSTRING(DATATERMINAL_TRIANGULATE),
        "",
        LINKFUNC(doTriangulate),
        {
            (_target animationSourcePhase "Antenna_source")>=3
        }
    ] call ace_interact_menu_fnc_createAction;
    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;
