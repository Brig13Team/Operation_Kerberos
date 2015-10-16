/*
	Author: iJesuz
	
	Description:
		
		initialization for logistics
		
	
	Parameter(s):
		none
		
	Returns:
		nothing
*/
#include "script_component.hpp"
SCRIPT(initServer);

QGVAR(updateSeats_Vehicle) addPublicVariableEventHandler {
	if (!local (_this select 1)) exitWith {};

	[_this select 1] call FUNC(updateSeats);
};