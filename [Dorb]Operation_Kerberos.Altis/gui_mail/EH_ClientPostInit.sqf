/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Client Post init
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

[
    localize LSTRING(APPNAME),
    {createDialog QAPP(dialog);},
    {[] call FUNC(canOpenMenu)},
    ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(echidna,mail)),
    3
] call EFUNC(gui_echidna,addApp);

GVAR(mail) = HASH_CREATE;

[
    QEGVAR(gui_mail,receive),
    LINKFUNC(receive)
] call CBA_fnc_addEventHandler;

[
    QEGVAR(gui_mail,receiveTask),
    LINKFUNC(receive)
] call CBA_fnc_addEventHandler;
