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
#include "script_component.hpp"
SCRIPT(disp_info);
CHECK(!hasInterface)
#define DISP_LAYER 700106
private["_type","_display","_headerCtrl","_contentCtrl","_contentAmountOfChars","_pos","_iconCtrl","_idc","_text"];
params[["_title","",[""]],["_content","",["",[]]],["_icon","",[""]],["_body",true,[false]]];

If(IS_STRING(_content)) then {_content = [_content];};

if (_title != "") then {
	DISP_LAYER cutRsc ["DORB_DISP_INFO","PLAIN"];
	If (islocalized _title) then {_title = localize _title;};
	disableSerialization;
	_display = uiNamespace getvariable "DORB_DISP_INFO";
	if (!isnil "_display") then {
		_headerCtrl = _display displayCtrl 700107;
		_headerCtrl ctrlSetText _title;
		
		_iconCtrl = _display displayCtrl 700108;
		_iconbodyCtrl = _display displayCtrl 700109;
		if (_icon != "") then {
			_iconCtrl ctrlSetText _icon;
			_iconCtrl ctrlCommit 0;
		}else{
			_iconCtrl ctrlSetPosition [0,0,0,0];
			_iconCtrl ctrlCommit 0;
			_body = false;
		};
		
		if (!(_body)) then {
			_iconbodyCtrl ctrlSetPosition [0,0,0,0];
			_iconbodyCtrl ctrlCommit 0;
		};
		
		_idc = 700110;
		{
			_text = _x;
			If (islocalized _text) then {_text = localize _text;};
			if (_text != "") then {
				_contentCtrl = _display displayCtrl _idc;
				_contentCtrl ctrlSetText _text;

				_contentAmountOfChars = count (toArray _text);
				_pos = ctrlPosition _contentCtrl;
				_pos set [2, _contentAmountOfChars * ((((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)/ 3.2) max (safeZoneW / 14)];
				_contentCtrl ctrlSetPosition _pos;
				_contentCtrl ctrlCommit 0;

				_idc = _idc + 1;
			};
		}foreach _content;

		while {(_idc < 700117)} do {
			_contentCtrl = _display displayCtrl _idc;
			_contentCtrl ctrlSetPosition [0,0,0,0];
			_contentCtrl ctrlCommit 0;

			_idc = _idc + 1;
		};
	};
} else {
	ERROR(FORMAT_1("DISP_INFO %1",_this));
	DISP_LAYER cutText ["","PLAIN"];
};