/*
	Author: Dorbedo
	
	Description:
		displays message
*/
#include "script_component.hpp"

CHECK(isDedicated)
DEFAULT_PARAM(0,_title,"");
DEFAULT_PARAM(1,_content,"");
#define DISP_LAYER 700100
private["_type","_display","_headerCtrl","_contentCtrl","_contentAmountOfChars","_pos"];
if (_title != "" && _content != "") then {
	DISP_LAYER cutRsc ["DORB_DISP_MSG","PLAIN"];
	disableSerialization;
	_display = uiNamespace getvariable "DORB_DISP_MSG";
	If (islocalized _title) then {_title = localize _title;};
	If (islocalized _content) then {_content = localize _content;};
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