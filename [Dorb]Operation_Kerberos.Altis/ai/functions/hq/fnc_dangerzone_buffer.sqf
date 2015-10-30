/*
	Author: Dorbedo
	
	Description:
		buffering the dangerzone
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(dangerzone_buffer);
#define VALUEMODIFICATOR 0.5
CHECK(GVAR(hq_buffer)isEqualTo [])

private "_temp"

_temp = GVAR(hq_buffer) deleteAt 0;

CHECK(_temp isEqualTo [])
_temp params [["_X_pos",0,[0]],["_Y_pos",0,[0]],["_value",0,[0]]];
TRACEV_3(_X_pos,_Y_pos,_value);
{
	([QGVAR(dangerzones)] append _x) call EFUNC(common,matrix_add);
} forEach [
	[_X_pos,_Y_pos,_value],
	[_X_pos-1,_Y_pos,_value*VALUEMODIFICATOR],
	[_X_pos+1,_Y_pos,_value*VALUEMODIFICATOR],
	[_X_pos,_Y_pos-1,_value*VALUEMODIFICATOR],
	[_X_pos,_Y_pos+1,_value*VALUEMODIFICATOR],
];