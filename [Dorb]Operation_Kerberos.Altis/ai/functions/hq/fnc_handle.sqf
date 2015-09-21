/*
	Author: Dorbedo
	
	Description:
		handles AI HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(handle);
CHECK(GETMVAR(GVAR(HQ_working),false))
SETMVAR(GVAR(HQ_working,true));

[] call FUNC(HQ_update_area);
CHECK((GETMVAR(EGVAR(HQ_centerpos),[]) isEqualTo []))


SETMVAR(GVAR(HQ_working),true);

