/*
 *  Author: Dorbedo
 *
 *  Description:
 *      start downloading
 *
 *  Parameter(s):
 *      0 : OBJECT - the Laptop
 *      1 : OBJECT - the caller
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_laptop","_caller"];

[
    10,
    [_laptop,_caller],
    {
        [QGVAR(effectDownload_Server),_args] call CBA_fnc_serverEvent;
    },
    {
        [LSTRING(LAPTOP_DOWNLOAD_CANCEL_MSG_TITLE),LSTRING(LAPTOP_DOWNLOAD_CANCEL_MSG)] call EFUNC(gui,Message);
    },
    localize LSTRING(LAPTOP_DOWNLOAD_PREPARE)
] call ace_common_fnc_progressBar
