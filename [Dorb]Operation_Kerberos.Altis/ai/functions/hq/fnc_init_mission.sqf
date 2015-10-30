/*
	Author: Dorbedo
	
	Description:
		initialiuzes AI HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(init_mission);
_this params[["_type","standard",[""]]];
TRACEV_1(_type);

GVAR(hq_aktive) = false;


GVAR(hq_callInArray) = switch (_type) do {
					//	infanterie	tanks	mech.	airdrop	attheli	plane	boat		fortifications	
	case "_test" : 	{[]};
	default 			{[	50,			10,		7,		7,		2,		10,		5,		8	];};

};
_multiplikator = 1; /// TODO

GVAR(hq_callInArray) = MAP(format["_this * %1",_multiplikator],GVAR(hq_callInArray));


[] call FUNC(reset);





