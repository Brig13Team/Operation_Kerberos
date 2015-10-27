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
SCRIPT(create_area);

ISNILS(GVAR(HQ_Centerpos),[])

_StartX=(GVAR(HQ_Centerpos) select 0)-2000;
_StartY=(GVAR(HQ_Centerpos) select 1)-2000;
GVAR(HQ_Startpos)=[_StartX,_StartY,0];

_buchstaben = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U"];

_hash=[];
_hash_number2=[];
for "_i" from 0 to 19 do {
	_temp = [];
	for "_j" from 0 to 21 do {
		_temp set [_j,[(_StartX+200*_i),(_j*200+_StartY)]];
	};
	_hash set [_i,[(_buchstaben select _i),_temp]];
	_hash_number2 set [_i,[(_buchstaben select _i),[0,[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]]]]
};

GVAR(HQ_Area_positions)=_hash;
















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