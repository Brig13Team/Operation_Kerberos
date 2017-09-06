/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the download-Device
 *
 *  Parameter(s):
 *      0 : OBJECT - Object to initialize the download
 *      1 : SCALAR - downloadtime
 *      2 : CODE/STRING - code to be executed on finish or Event to be called on finish
 *      3 : ARRAY - parameter
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    ["_object",objNull,[[],objNull]],
    ["_downloadtime",600,[0]],
    ["_onFinish",{},["",{}]],
    ["_parameter",[],[[]]]
];

If (IS_ARRAY(_object)) then {
    {
        _x call FUNC(init_Download);
    } forEach _object;
};

_object setVariable [QGVAR(isDownload),true,true];
_object setVariable [QGVAR(DownloadProgress),-1,true];
_object setVariable [QGVAR(DownloadTime),_downloadtime];
_object setVariable [QGVAR(onDownloadFinish),_onFinish];
_object setVariable [QGVAR(onDownloadFinishParams),_parameter];

// initialize the download steps

//
