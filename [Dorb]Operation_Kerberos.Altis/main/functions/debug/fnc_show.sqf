/*
	Author: Dorbedo
	
	Description:
		shows message in systemchat
	
	Parameter(s):
		0: STRING - Message
		
	Return
		None
*/
#include "script_component.hpp"
SCRIPT(show);
params["_message"];

systemchat _message;

nil