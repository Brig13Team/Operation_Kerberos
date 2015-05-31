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

CHECK(isDedicated)

#define DISP_LAYER 700100
private["_title", "_content","_type","_display","_headerCtrl","_contentCtrl","_contentAmountOfChars","_pos"];
_title = [_this, 0, "",[""]] call BIS_fnc_Param;
_content = [_this, 1, "",[""]] call BIS_fnc_Param;


if (_title != "" && _content != "") then {
	DISP_LAYER cutRsc ["DORB_DISP_MSG","PLAIN"];
	disableSerialization;
	_display = uiNamespace getvariable "DORB_DISP_MSG";
	if (!isnil "_display") then {
		_headerCtrl = _display displayCtrl 700101;
		_contentCtrl = _display displayCtrl 700102;
		_headerCtrl ctrlSetText _title;
		_contentCtrl ctrlSetText _content;
		_contentAmountOfChars = count (toArray _content);
		_pos = ctrlPosition _contentCtrl;
		_pos set [2, _contentAmountOfChars * ((((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)/ 3.2) max (safeZoneW / 14)];
		_contentCtrl ctrlSetPosition _pos;
		_contentCtrl ctrlCommit 0;
	};
};