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

private "_return";
_return = [GETMVAR(GVAR(HQ_Centerpos,[])),100,2000,] call FUNC(pos_square);
_return params [_parameter,_area];

SETMVAR(GVAR(HQ_Area_params),_parameter);
SETMVAR(GVAR(HQ_Area_positions),_area);
private "_weight";
_weight = [];
{
	_weight set[_forEachIndex,0];
}forEach _area;
SETMVAR(GVAR(HQ_Area_weight),_weight);