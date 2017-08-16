/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if data can be downloaded
 *
 *  Parameter(s):
 *      0 : OBJECT - the Laptop
 *      1 : OBJECT - the caller
 *
 *  Returns:
 *      BOOL - somthing can be downloaded
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_laptop","_caller"];

#ifndef DEBUG_MODE_FULL
    (_laptop getVariable[QGVAR(isDownload),false])&&
    (!(_laptop getVariable[QGVAR(DownloadInProgress),false]))
#else
    true
#endif
