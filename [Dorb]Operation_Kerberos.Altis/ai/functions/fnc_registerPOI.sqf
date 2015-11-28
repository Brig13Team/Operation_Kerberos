/*
	Author: Dorbedo
	
	Description:
		registers a Point of interest
	
	Parameter(s):
		0:OBJECT/POSITION	- the position to be defended

	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(registerGroup);
_this params[["_POI",[],[[],objNull],[2,3]]];
If (_POI isEqualTo []) exitWith {false};

If (IS_OBJECT(_POI)) then {
	_POI = getPos _POI;
};


GVAR(POI) pushBack _POI;
true
