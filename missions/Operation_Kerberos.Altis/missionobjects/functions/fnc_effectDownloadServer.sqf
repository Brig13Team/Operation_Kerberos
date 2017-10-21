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
TRACE("Download started");
private _handlerID = [
    {
        _this params ["_args","_handler"];
        _args params [["_laptop",objNull,[objNull]],"_caller"];
        If (isNull _laptop) exitWith {
            ERROR("The Download Object has been deleted.");
            [_handler] call CBA_fnc_removePerFrameHandler;
        };
        private _nearPlayers = {(_x distance2D _laptop) < DOWNLOAD_MAX_DISTANCE} count (allPlayers select {side _x == GVARMAIN(playerside)});
        If (_nearPlayers <1) exitWith {};
        private _progress = _laptop getVariable [QGVAR(DownloadProgress),0];
        private _downloadTime = _laptop getVariable [QGVAR(DownloadTime),600];

        /*
         * TODO:    do some amazing math to make the download look amazing.
         *          for now it's only time related
         */

         _progress = _progress + 1;
         _laptop setVariable [QGVAR(DownloadProgress),_progress,true];

         If (_progress > _downloadTime) exitWith {
             LOG("Download finished");
             [LSTRING(LAPTOP_DOWNLOAD_FINISHED_MSG_TITLE),LSTRING(LAPTOP_DOWNLOAD_FINISHED_MSG)] call EFUNC(gui,globalMessage);
             [_handler] call CBA_fnc_removePerFrameHandler
         };

         // JIP Update
         If ((floor(_progress))mod 10 == 0) then {
             [
                QGVAR(effectDownload_Client),
                [_laptop,_caller]
             ] call CBA_fnc_globalEvent;
         };
    },
    1,
    [_laptop,_caller]
] call CBA_fnc_addPerFrameHandler;
_laptop setVariable [QGVAR(DownloadHandler),_handlerID];
[
   QGVAR(effectDownload_Client),
   [_laptop,_caller]
] call CBA_fnc_globalEvent;
