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
params[["_header","",[""]],"_addon",["_part","main",[""]],["_message","",[""]],["_file","",[""]],"_line"];
private["_lines","_time"];
If (_message isEqualTo "") exitWith {
    [format["[%1_%2%3:%4]-%5 (%6:%7) ERROR-LOGAUFRUF",_addon,_part,_file,_line,_time,diag_tickTime,diag_frameNo]] call FUNC(debug_write);
};
private["_lines","_time"];
_lines = [_message,"\n"] call CBA_fnc_split;
_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;
if (!(_file isEqualTo "")) then {
    _file=[_file,"\fnc"] call CBA_fnc_split;
    _file=_file select ((count _file)-1);
    [format["[%1_fnc_%2%3:%4]-%5 (%6:%7) %8",_addon,_part,_file,_line,_time,diag_tickTime,diag_frameNo,_header]] call FUNC(debug_write);
}else{
    [format["[%1_fnc_%2]-%3 (%4:%5) %6",_addon,_part,_time,diag_tickTime,diag_frameNo,_header]] call FUNC(debug_write);
};

{
    [format["        %1",_x]] call FUNC(debug_write);
    nil
}count _lines;

If (isServer&&hasinterface&&_header in ["ERROR","WARNING","TRACE"]) then {
    [format["[%1_fnc_%2%3:%4]-%5 (%6:%7) %8",_addon,_part,_file,_line,_time,diag_tickTime,diag_frameNo,(_lines deleteAt 0)]] call FUNC(debug_show);
    {
        [_x] call FUNC(debug_show);
        nil
    }count _lines;
};
nil