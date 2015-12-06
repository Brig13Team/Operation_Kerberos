/*
	Author: Dorbedo
	
	Description:
		returns the neares waypoint-key
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_next);
_this params[
	["_position",[],[[]]]
	];
TRACEV_1(_position);
_raster = getNumber(missionconfigFile >> "maps" >> worldname >> "raster");

TRACEV_1(_raster);
_keyX = round(((_position select 0)-_raster*0.5)/_raster)*(_raster/10);
_keyY = round(((_position select 1)-_raster*0.5)/_raster)*(_raster/10);


format["%1_%2",_keyX,_keyY];
