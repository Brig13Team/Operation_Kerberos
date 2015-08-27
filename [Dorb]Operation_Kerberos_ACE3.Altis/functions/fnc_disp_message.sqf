/*
	Author: Dorbedo
	
	Description:
		displays message
	
	Parameter(s):
		0 : STRING - Title
		1 : STRING - Message
	
*/
#include "script_component.hpp"
SCRIPT(disp_message);
CHECK(!hasInterface)
#define DISP_LAYER 700100
#define FONT_CORRECTION_CAPITAL 17
#define FONT_CORRECTION_LOWER 5.7
params[["_title","",[""]],["_content","",[""]]];
CHECK((_title isEqualTo "")&&(_content isEqualTo ""))

DISP_LAYER cutRsc ["DORB_DISP_MSG","PLAIN"];
disableSerialization;
_disp = uiNamespace getvariable "DORB_DISP_MSG";
If (islocalized _title) then {_title = localize _title;};
If (islocalized _content) then {_content = localize _content;};
CHECK(isNil "_disp")
{
	private["_ctrl","_chars","_size","_pos"];
	_x params ["_idc",["_text","",[""]]];
	_ctrl = _disp displayCtrl _idc;
	_ctrl ctrlSetText _text;
	_chars = count(_text);
	_size = 0;
	If (_chars>0) then {
		private["_chars_capital","_chars_array"];
		_chars_array = toArray _text;
		_chars_capital = {If ((_x>=65)&&(_x<=90)) then {true}else{false};} count _chars_array;
		_size = ((((safeZoneW min safeZoneH)*0.9)*((ctrlTextHeight _ctrl)/FONT_CORRECTION_CAPITAL))*_chars_capital + 0.012)+((((safeZoneW min safeZoneH)*0.9)*((ctrlTextHeight _ctrl)/FONT_CORRECTION_LOWER))*_chars + 0.012);
	};
	_pos = ctrlPosition _ctrl;
	_pos set [2, _size];
	_ctrl ctrlSetPosition _pos;
	_ctrl ctrlCommit 0;
}forEach [
	[700101,_title],
	[700102,_content]
];
