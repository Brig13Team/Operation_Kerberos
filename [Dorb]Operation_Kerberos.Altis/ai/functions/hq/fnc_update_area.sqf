/*
	Author: Dorbedo
	
	Description:
		updates the Area of the HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(update_area);

ISNILS(GVAR(HQ_Centerpos),[])

If (GETMVAR(EGVAR(mission,area),[])==GETMVAR(GVAR(HQ_Centerpos),[])) exitWith {};

SETMVAR(GVAR(HQ_Centerpos),(GETMVAR(EGVAR(mission,area),[])));

_area = [GETMVAR(GVAR(HQ_Centerpos,[]))] call FUNC(pos_square);

SETMVAR(GVAR(HQ_Area),_area);


