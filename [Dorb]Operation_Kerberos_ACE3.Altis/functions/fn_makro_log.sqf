/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"


if (!(isServer)) exitWith {true};
private ["_scriptName","_log","_input","_level"];
_input = [_this, 0, "ERROR - LOGAUFRUF"] call BIS_fnc_Param;
_fname = [_this, 1, "",[""]] call BIS_fnc_Param;
_pname = [_this, 2, "",[""]] call BIS_fnc_Param;

_text="";

If (_pname != "") then {
	_text = "[" + _pname + ">>" + _fname+ "] - ";
}else{
	_text = "["+_fname+"] - ";
};


/*
{
	_text = format["%1 %2",_text,_x];
}forEach _input;
*/
_text=FORMAT_2("%1 %2",_text,_input);

diag_log _text;

