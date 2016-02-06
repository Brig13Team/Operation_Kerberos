/*
    Author: Dorbedo
    
    Description:
        formats the message
    
    Parameter(s):
        0: STRING - ADDON
        1: STRING - PART
        2: STRING - MESSAGE
        3: STRING - FILE
        4: SCALAR - LINE
        
    Return
        nil
*/
#include "script_component.hpp"
_this params[["_header","",[""]],["_functionname","",[""]],["_functionnameParent","",[""]],["_message","",[""]],["_file","",[""]],"_line"];

If (_message isEqualTo "") exitWith {
    [format["[%1:%2] (%3:%4) ERROR-LOGAUFRUF file:%5",_functionname,_line,diag_tickTime,diag_frameNo,_file]] call FUNC(debug_write);
};
private _lines = [_message,"\n"] call CBA_fnc_split;
private _time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;
if (!(_file isEqualTo "")) then {
    _file = [_file,"\fnc"] call CBA_fnc_split;
    _file = _file select ((count _file)-1);
    If (_functionname isEqualTo _functionnameParent) then {
        [format["[%1:%2]-%3 (%4:%5) %6 file:%7",_functionname,_line,_time,diag_tickTime,diag_frameNo,_header,_file]] call FUNC(debug_write);
    }else{
        [format["[%1:%2/%8]-%3 (%4:%5) %6 file:%7",_functionname,_line,_time,diag_tickTime,diag_frameNo,_header,_file,_functionnameParent]] call FUNC(debug_write);
    };
}else{
    If (_functionname isEqualTo _functionnameParent) then {
        [format["[%1]-%2 (%3:%4) %5",_functionname,_time,diag_tickTime,diag_frameNo,_header]] call FUNC(debug_write);
    }else{
        [format["[%1/_functionnameParent]-%2 (%3:%4) %5",_functionname,_time,diag_tickTime,diag_frameNo,_header]] call FUNC(debug_write);
    };
};

If (_functionname isEqualTo "") then {
    [format["        ERROR - Spawned Function without name in file:%1",_file]] call FUNC(debug_write);
};

{
    [format["        %1",_x]] call FUNC(debug_write);
    nil
}count _lines;

If (isServer&&hasinterface&&_header in ["ERROR","WARNING","TRACE"]) then {
    If (_functionname isEqualTo _functionnameParent) then {
        [format["[%1:%2]-%3 (%4:%5) %6 ",_functionname,_line,_time,diag_tickTime,diag_frameNo,(_lines deleteAt 0)]] call FUNC(debug_show);
    }else{
        [format["[%1:%2/%7]-%3 (%4:%5) %6 ",_functionname,_line,_time,diag_tickTime,diag_frameNo,(_lines deleteAt 0),_functionnameParent]] call FUNC(debug_show);
    };
    {
        [_x] call FUNC(debug_show);
        nil
    }count _lines;
};
nil