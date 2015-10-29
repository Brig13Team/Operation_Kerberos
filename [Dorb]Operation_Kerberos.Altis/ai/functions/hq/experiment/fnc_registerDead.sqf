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
_this params [["_positionDead",[],[[]],[2,3]]];
private "_area";
_area = GETMVAR(GVAR(HQ_Area_killed),[]);
/// [  [_position,_step,_sideX,_sideY]   ,   [    ]  ]

If ((count (GETMVAR(GVAR(HQ_Area_killed),[])))!=(count (GETMVAR(GVAR(HQ_Area_positions),[])))) then {
	private "_temp";
	_temp = [];
	{
		_temp pushBack [0];
	}forEach (GETMVAR(GVAR(HQ_Area_killed),[]));
	SETMVAR(GVAR(HQ_Area_killed),_temp);
};
private "_temp";
_temp = GETMVAR(GVAR(HQ_Area_killed),[]);
(_area select 0) params ["_position","_step","_sideX","_sideY"];

// Check if position of the dead is to far away from the HQ_Area
If ((((_position select 0)-(0.5*_sideX))>(_positionDead select 0))||(((_position select 0)+(0.5*_sideX))>(_positionDead select 0))) exitWith {};
If ((((_position select 1)-(0.5*_sideY))>(_positionDead select 1))||(((_position select 1)+(0.5*_sidey))>(_positionDead select 1))) exitWith {};

_deadX = floor(((_positionDead select 0)-(_position select 0))/_step);
_deadY = floor(((_positionDead select 1)-(_position select 1))/_step);
_rowcountY = (floor(_sideY/_step));
_arraypos = 1 + (_rowcountY * _deadY) + _deadX;

_temp set [_arraypos,((_temp select _arraypos)+1)]

SETMVAR(GVAR(HQ_Area_killed),_temp);