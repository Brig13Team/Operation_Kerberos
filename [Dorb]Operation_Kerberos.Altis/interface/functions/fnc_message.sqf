/*
    Author: Dorbedo
    
    Description:
        displays message
    
    Parameter(s):
        0 : STRING - Title
        1 : STRING - Message
		2 : STRING - Color
    
*/
#include "script_component.hpp"
CHECK(!hasInterface)
_this params[["_title","",[""]],["_content","",[""]],["_color","",[""]]];

If (islocalized _title) then {_title = localize _title;};
If (islocalized _content) then {_content = localize _content;};

GVAR(msg_cur) = GVAR(msg_cur) select {!(isNull(_x select 0))};

GVAR(msg_cur_ID)=If (GVAR(msg_cur_ID)>=9) then {
	GVAR(msg_cur_ID)=1;
}else{
	INC(GVAR(msg_cur_ID));
};


