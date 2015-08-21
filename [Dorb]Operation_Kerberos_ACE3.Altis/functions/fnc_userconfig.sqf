/*
	Author: Dorbedo
	
	Description:
		Loads Variables from Userconfig
	
	Parameter(s):
		None
		
	Return
		None
*/
#include "script_component.hpp"
private["_userconfig"];

_userconfig = compile preprocessFileLineNumbers "\userconfig\kerberos\dorb_userconfig.sqf";
if (!isNil "_userconfig") then {
	[] call _userconfig; // Load the global defaults
};
ISNILS(DORB_RESERVED_PILOT,[]);
ISNILS(DORB_RESERVED_ZEUS,[]);