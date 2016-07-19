/*
    Author: Dorbedo
    
    Description:
        displays message local
    
    Parameter(s):
        0 : STRING - Title
        1 : STRING - Message
		2 : STRING - Color
    
*/
#include "script_component.hpp"
#define MOVINGTIME 1.4
CHECK(!hasInterface)
_this params[["_title","",[""]],["_content","",[""]],["_color","",[""]]];

If (isClass(missionconfigfile>>"CfgMessages">>_title)) then {
	_title = getText(missionconfigfile>>"CfgMessages">>_title>>"title");
	_content = getText(missionconfigfile>>"CfgMessages">>_title>>"text");
	_color = getArray(missionconfigfile>>"CfgMessages">>_title>>"color");
}else{
	If (islocalized _title) then {_title = localize _title;};
	If (islocalized _content) then {_content = localize _content;};
	_color = switch (_color)  do {
		case "red" : {[RAL3024,1]};
		case "green" : {[RAL6018,1]};
		case "blue" : {[RAL5015,1]};
		default {[RAL1013,1]};
	};
};
disableSerialization;

GVAR(msg_cur) = GVAR(msg_cur) - [displayNull];

If (GVAR(msg_cur) isEqualTo []) then {
	If (isNil QGVAR(msg_move)) then {
		GVAR(msg_move) = abs(( call compile(getText(missionconfigfile>>"RscTitles">>QGVAR(message_1)>>"h"))  ) + 0.5 *( call compile (getText(missionconfigfile>>"RscTitles">>QGVAR(message_1)>>"controls">>"header">>"h"))  ));
	};
	GVAR(msg_cur_ID)=1;
	QGVAR(message_1) cutRsc [QGVAR(message_1),"PLAIN"];
	//cutRsc [QGVAR(message_1),"PLAIN"];
	private _idd = GVAR(msg_cur) select (count (GVAR(msg_cur)) - 1);
	(_idd displayCtrl 770111) ctrlSetText _title;
	(_idd displayCtrl 770112) ctrlSetBackGroundColor _color;
	(_idd displayCtrl 770113) ctrlSetStructuredText (parseText _content);
	
	[] spawn {
		disableSerialization;
		while {!(GVAR(msg_cur) isEqualTo [])} do {
			GVAR(msg_cur) = GVAR(msg_cur) - [displayNull];
		
			If !(GVAR(msg_waiting) isEqualTo []) then {
				/// pushdown the old ones;
				{
					private _idd = _x;
					{
						private _pos = ctrlPosition (_idd displayCtrl _x);
						(_idd displayCtrl _x) ctrlSetPosition [_pos select 0,((_pos select 1) + GVAR(msg_move))];
						(_idd displayCtrl _x) ctrlCommit MOVINGTIME;
					}forEach [770111,770112,770113];
				}forEach GVAR(msg_cur);
				uisleep MOVINGTIME;
				/// new display
				If (GVAR(msg_cur_ID)>=9) then {
					GVAR(msg_cur_ID)=1;
				}else{
					INC(GVAR(msg_cur_ID));
				};
				
				(GVAR(msg_waiting) deleteAt 0) params ["_title","_content","_color"];
				format[QGVAR(message_%1),GVAR(msg_cur_ID)] cutRsc [format[QGVAR(message_%1),GVAR(msg_cur_ID)],"PLAIN"];
				//cutRsc [format[QGVAR(message_%1),GVAR(msg_cur_ID)],"PLAIN"];
				private _idd = GVAR(msg_cur) select (count (GVAR(msg_cur)) - 1);
				(_idd displayCtrl 770111) ctrlSetText _title;
				(_idd displayCtrl 770112) ctrlSetBackGroundColor _color;
				(_idd displayCtrl 770113) ctrlSetStructuredText (parseText _content);
			};
		
			uisleep 1;
		};
	};
}else{
	GVAR(msg_waiting) pushBack [_title,_content,_color];
};
