/*
 *  Author: Dorbedo
 *
 *  Description:
 *      writes the function map to the rpt
 *
 *  Parameter(s):
 *      0 : STRING - header
 *      1 : STRING - functionname
 *      2 : STRING - functionparent
 *      3 : ARRAY - mapping array
 *      4 : STRING - filename
 *      5 : SCALAR - line
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params[["_header","",[""]],["_functionname","",[""]],["_functionnameParent","",[""]],["_mapArray",[],[[]]],["_file","",[""]],"_line"];
private _message = "MAPPED: ";
{
    _message = format["%1>>%2",_message,_x];
} forEach _mapArray;

["_header","_functionname","_functionnameParent","_message","_file","_line"] spawn FUNC(debug_putinlog);

nil;
