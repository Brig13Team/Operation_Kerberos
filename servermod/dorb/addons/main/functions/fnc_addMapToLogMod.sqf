/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the main logging function
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"
_this params [
    ["_mapArray",[],[[]]],
    ["_logLevel","",[""]],
    ["_componentName","",[""]],
    ["_fileName","",[""]],
    "_line",
    ["_frameNumber",-1,[0]],
    ["_scriptName","",["",[]],[2]]
    ];

If (_mapArray isEqualTo []) exitWith {
    private _message = "mapping called without map-array";
    [_message,_logLevel,_componentName,_fileName,_line,_frameNumber,_scriptName] call FUNC(addToLog);
};

private _message = _mapArray deleteAt 0;

{
    _message = _message + ">>";
    If ((_forEachIndex>0)&&((_forEachIndex mod 3)==0)) then {
        _message = _message + "\n";
    };
} forEach _mapArray;

[_message,_logLevel,_componentName,_fileName,_line,_frameNumber,_scriptName] call FUNC(addToLog);
