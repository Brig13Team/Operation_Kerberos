	/*
	Author: Dorbedo

	Description:
		Creates Mission "CLEAR".

	Parameter(s):
		0 :	ARRAY - Position

	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(clear);
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])

/********************
	taskhandler
********************/

[
	QUOTE(private '_a';_a = {(((side _x)!=GVARMAIN(playerside))&&((_x distance (_this select 0))<2500))}count allUnits;If (_a < 15) then {true}else{false};),
	[_position]
]