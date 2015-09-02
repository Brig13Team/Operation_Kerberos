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
SCRIPT(write);
params["_message"];

diag_log text _message;