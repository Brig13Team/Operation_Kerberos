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

If !(isNil QGVAR(loggingHandler)) exitWith {
    GVAR(logging) pushBack _this;
};

GVAR(loggingHandler) = _this spawn {
//    [{
        GVAR(logging) = [_this] + (missionNamespace getVariable [QGVAR(logging),[]]);
        while {(count GVAR(logging))>0} do {
            (GVAR(logging) deleteAt 0) params [
                ["_message","",[""]],
                ["_logLevel","",[""]],
                ["_componentName","",[""]],
                ["_fileName","",[""]],
                "_line",
                ["_frameNumber",-1,[0]],
                ["_scriptName","",["",[]],[2]]
            ];
            // Check for invalid input
            If ((_message isEqualTo "") ||
                (_logLevel isEqualTo "") ||
                (_componentName isEqualTo "") ||
                (_fileName isEqualTo "") ||
                (_frameNumber < 0)
            ) then {_message = "WRONG DEBUG CALLING\n" + _message;};

            // Logging
            private _lines = [_message,"\n"] call CBA_fnc_split;
            _fileName = [_fileName,"\"] call CBA_fnc_split;
            _fileName = (_fileName select ((count _fileName)-1));
            If (IS_ARRAY(_scriptName)) then {
                diag_log text format["[MissionFile] (%1) - %2: ~\%3:%4 [%5]  %6<<%7",_componentName,_logLevel,_fileName,_line,_frameNumber,(_scriptName select 0),(_scriptName select 1)];
            }else{
                diag_log text format["[MissionFile] (%1) - %2: ~\%3:%4 [%5]  %6",_componentName,_logLevel,_fileName,_line,_frameNumber,_scriptName];
            };

            {
                diag_log text format["              %1",_x];
            } forEach _lines;
            If (isServer&&hasinterface&&_logLevel in ["ERROR","WARNING","TRACE"]) then {
                systemchat format["[MissionFile] (%1) - %2: ~\%3:%4 [%5]",_componentName,_logLevel,_fileName,_line,_frameNumber];
                {systemChat _x; nil } count _lines;
            };
        };
        GVAR(loggingHandler) = nil;
//    },_this] call CBA_fnc_directCall;
};
