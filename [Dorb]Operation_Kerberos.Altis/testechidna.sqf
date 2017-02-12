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
#include "script_component.hpp"


for "_i" from 0 to 10 do {

    [
        format["Test%1",_i],
        {hint "klick";},
        {false},
        ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_tank)),
        (floor(random 3)+1),
        []
    ] call EFUNC(gui_echidna,addApp);

};
