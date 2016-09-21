/*
	Author: Dorbedo

	Description:
		adds Arsenal to a unit
		can be called via unit-init
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(addArsenal);
_this params [["_target",objNull,[objNull]]];
LOG_1(_target);
CHECK((isNull _target)||(!(local _target)))
//["AmmoboxInit",[_target,true,{true}]] call BIS_fnc_arsenal;

[_target,EGVAR(main,playerside)] call FUNC(addSideRestrictedArsenal);
