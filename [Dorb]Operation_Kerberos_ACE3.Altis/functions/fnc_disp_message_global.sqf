/*
	Author: Dorbedo
	
	Description:
		displays message global
		(is localized on client, if String is given)
	
	Parameter(s):
		0 :	STRING - Title 
		1 :	STRING - Beschreibung
	
	
	
*/
#include "script_component.hpp"

DEFAULT_PARAM(0,_title,"");
DEFAULT_PARAM(1,_content,"");

[-1,{_this spawn FM(disp_message);},[_title,_content]] FMP;