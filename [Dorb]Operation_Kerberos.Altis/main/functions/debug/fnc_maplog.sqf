/*
    Author: Dorbedo
    
    Description:
        writes the called map to the rpt
    
    Parameter(s):
        0: ARRAY - maparray
        
    Return
        None
*/
#include "script_component.hpp"
_this params[["_header","",[""]],["_functionname","",[""]],["_functionnameParent","",[""]],["_mapArray",[],[[]]],["_file","",[""]],"_line"];
private _message = "MAPPED: ";
{
    _message = format["%1>>%2",_message,_x];
} forEach _mapArray;

["_header","_functionname","_functionnameParent","_message","_file","_line"] spawn FUNC(debug_putinlog);

nil;