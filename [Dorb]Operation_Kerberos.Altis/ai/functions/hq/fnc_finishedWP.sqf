/*
	Author: Dorbedo
	
	Description:
		called vio waypoint statement
		modifies the value of the Position and the sourrounding area
	
	Parameter(s):
		0 : OBJECT - Groupleader
		1 : SCALAR - Value to Modify the position
		2 : SCALAR - Value to modify the surrounding area (multiplikator of value1)

	Returns:
		none
*/

#include "script_component.hpp"
SCRIPT(finishedWP);

_this params [
	["_leader",objNull,[objNull]],
	["_modposition",0,[0]],
	["_modsurrounding",0,[0]]
];

private ["_grouppos"];

_grouppos = getPos _leader;

_parameter = GETMVAR(GVAR(HQ_Area_params),[]);
_area = GETMVAR(GVAR(HQ_Area_weight),[]);

_parameter params ["_position","_step","_sideX","_sideY"];

_posX = (_grouppos select 0)-(_position select 0);
_posY = (_grouppos select 1)-(_position select 1);

CHECK((_posX<0)||(_posY<0))

_idX = floor(_posX/_step);
_idY = floor(_posY/_step);

_X_count = floor(_sideX/_step);
_Y_count = floor(_sideY/_step);

_count = count _area;

//[0,0,0,0,0,0,0,
// 0,0,0,1,0,0,0,
// 0,0,1,2,1,0,0,
// 0,1,2,3,2,1,0,
// 0,0,1,2,1,0,0,
// 0,0,0,1,0,0,0,
// 0,0,0,0,0,0,0]

_row = floor(_idX/_X_count);
_column = floor(_idY/_Y_count);

_change_value=[];

{
	_x params ["_id","_value"];
	If ((_id>=0)&&(_id<_count)) then {
		_area set [_id,(_value+(_area select _id))];
	};
}forEach [
	[(_row*_column+_row),_modposition],
	
	[(_row*_column+_row-1),_modposition*_modsurrounding],
	[(_row*_column+_row+1),_modposition*_modsurrounding],
	[((_row+1)*_column+_row),_modposition*_modsurrounding],
	[((_row-1)*_column+_row),_modposition*_modsurrounding],
	
	[(_row*_column+_row-2),_modposition*_modsurrounding*_modsurrounding],
	[(_row*_column+_row+2),_modposition*_modsurrounding*_modsurrounding],
	[((_row-1)*_column+_row-1),_modposition*_modsurrounding*_modsurrounding],
	[((_row-1)*_column+_row+1),_modposition*_modsurrounding*_modsurrounding],
	[((_row+1)*_column+_row-1),_modposition*_modsurrounding*_modsurrounding],
	[((_row+1)*_column+_row+1),_modposition*_modsurrounding*_modsurrounding],
	[((_row+2)*_column+_row),_modposition*_modsurrounding*_modsurrounding],
	[((_row-2)*_column+_row),_modposition*_modsurrounding*_modsurrounding]
];

SETMVAR(GVAR(HQ_Area_weight),_area);