/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
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
