/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the download-Device
 *
 *  Parameter(s):
 *      0 : OBJECT - Object to initialize the download
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_object",objNull,[[],objNull]]];

If (IS_ARRAY(_object)) then {
    {
        _x call FUNC(obj_init_Download);
    } forEach _object;
};

_object setVariable [QGVAR(isDownload),true,true];
_object setVariable [QGVAR(DownloadInProgress),false,true];




















//
