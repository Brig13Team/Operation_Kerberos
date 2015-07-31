/*
	Author: Dorbedo
	
	Description:
		displays info global
		(is localized on client, if String is given)
	
	Parameter(s):
		0 :	STRING - Title 
		1 :	STRING or Array - Beschreibung
		3 : STRING - Iconpath
		4 : BOOL	- Body for Icon is shown
	
	
	
*/
#include "script_component.hpp"
SCRIPT(disp_info_global);
DEFAULT_PARAM(0,_title,"");
private "_content";
_content = [_this,1,"",["",[]]] call BIS_fnc_Param;
DEFAULT_PARAM(2,_icon,"");
DEFAULT_PARAM(3,_body,true);

If (IS_STRING(_content)) then {_content = [_content];};

[-1,{_this spawn FM(disp_info)},[_title,_content,_icon,_body]] FMP;