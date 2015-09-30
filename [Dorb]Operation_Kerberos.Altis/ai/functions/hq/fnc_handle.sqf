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
CHECK((GETMVAR(GVAR(HQ_centerpos),[]) isEqualTo []))

//// Update Variables/Groups




//// Gather Informations -> where does the enemy attack
// Check Radars
// Check Spotters
// Check Requests
// Areas where many Soldiers where lost.

//// Calculate the dangerzones





//// Check for availlaible Squads in Range




///// Make decisions




//// Update ideling Patrols






//// Call Support (Call-In Units or Off-Map Support)




SETMVAR(GVAR(HQ_working),false);

