/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Post Init Header
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

[
    QGVAR(addMessage),
    {_this call FUNC(addMessage);}
] call CBA_fnc_addEventHandler;

private _ACE_Action = [
    QGVAR(selfactiongroup),
    localize LSTRING(SELFACTIONGROUP),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(logo,logo_512),
    LINKFUNC(open),
    LINKFUNC(canOpenMenu)
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;

{
    _x params ["_Red","_Green","_Blue"];
    missionNamespace setVariable [format[QGVAR(METRO_BUTTON_%1_RGB_R),_forEachIndex + 1],_Red/255];
    missionNamespace setVariable [format[QGVAR(METRO_BUTTON_%1_RGB_G),_forEachIndex + 1],_Green/255];
    missionNamespace setVariable [format[QGVAR(METRO_BUTTON_%1_RGB_B),_forEachIndex + 1],_Blue/255];
} forEach [
    [243,178,0,255],
    [99,47,0,255],
    [0,193,63,255],
    [70,23,180,255],
    [170,64,255,255],
    [145,209,0,255],
    [254,124,34,255],
    [199,185,0,255],
    [176,30,0,255],
    [0,106,193,255],
    [255,152,29,255],
    [31,174,255,255],
    [255,183,0,255],
    [37,114,235,255],
    [193,0,79,255],
    [0,130,135,255],
    [255,46,18,255],
    [86,197,255,255],
    [255,118,188,255],
    [173,16,60,255],
    [144,0,172,255],
    [25,153,0,255],
    [255,29,199,255],
    [0,216,204,255],
    [0,163,163,255]
];
