/*
 *  Author: Dorbedo
 *
 *  Description:
 *      local handling of the progessbar
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
If !((_laptop getVariable [QGVAR(DownloadHandlerC),-1])<0) exitWith {};

private _handlerID = [
    {
        _this params ["_args","_handler"];
        _args params [["_laptop",objNull,[objNull]],["_caller",objNull,[objNull]]];
        If (isNull _laptop) exitWith {
            ERROR("The Download Object has been deleted.");
            [_handler] call CBA_fnc_removePerFrameHandler;
            [] call EFUNC(gui,endLoadingBar);
        };
        private _progress = _laptop getVariable [QGVAR(DownloadProgress),0];
        private _downloadTime = _laptop getVariable [QGVAR(DownloadTime),600];

        If ((player distance _laptop) > DOWNLOAD_MAX_DISTANCE) exitWith {
            If ([] call EFUNC(gui,isLoadingBarShown)) then {
                [] call EFUNC(gui,endLoadingBar);
            };
        };
        If !([] call EFUNC(gui,isLoadingBarShown)) then {
            [] call EFUNC(gui,startLoadingBar);
        };

        [_progress,0,_downloadTime] call EFUNC(gui,progressLoadingBar);

         If (_progress > _downloadTime) exitWith {
             LOG("Download finished");
             [_handler] call CBA_fnc_removePerFrameHandler;
             [] call EFUNC(gui,endLoadingBar);
         };
    },
    1,
    [_laptop,_caller]
] call CBA_fnc_addPerFrameHandler;
_laptop setVariable [QGVAR(DownloadHandlerC),_handlerID];
