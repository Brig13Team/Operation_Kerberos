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

_this params ["_laptop","_caller"];

// exit if the download has already started
If (
    ((_laptop getVariable [QGVAR(DownloadProgress),-1])>=0)&&
    ((_laptop getVariable [QGVAR(DownloadHandler),-1])<0)
) exitWith {};


_laptop setVariable [QGVAR(DownloadStart),CBA_missiontime];
private _handlerID = [
    {
        _this params ["_args","_handler"];
        _args params ["_laptop"];
        private _nearPlayers = {(_x distance2D _laptop) < 10} count allPlayers;
        If (_nearPlayers <1) exitWith {};
        private _progress = _laptop getVariable [QGVAR(DownloadProgress),0];
        private _downloadTime = _laptop getVariable [QGVAR(DownloadTime),600];
        private _curState = _progress * _

    },
    1,
    [_laptop]
] call CBA_fnc_addPerFrameHandler;
_laptop setVariable [QGVAR(DownloadHandler),_handlerID];



_object setVariable [QGVAR(isDownload),true,true];
_object setVariable [QGVAR(DownloadProgress),-1,true];
_object setVariable [QGVAR(DownloadTime),_downloadtime];
_object setVariable [QGVAR(onDownloadFinish),_onFinish];
_object setVariable [QGVAR(onDownloadFinishParams),_parameter];






["herunterladen","herunterladend"] call EFUNC(gui,globalMessage);
