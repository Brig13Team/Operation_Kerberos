/*
	Author: Dorbedo
	
	Description:
		Headless perframeEH
		
	[{ [] call dorb_fnc_headless } , 30, [] ] call CBA_fnc_addPerFrameHandler;
	
	
*/
#include "script_component.hpp"
SCRIPT(headless);

CHECK(!isMultiplayer)
ISNILS(DORB_HEADLESS_ALL,(allMissionObjects "HeadlessClient_F"));
CHECK(DORB_HEADLESS_ALL isEqualTo [])
ISNILS(DORB_HEADLESS_CUR,(DORB_HEADLESS_ALL select 0));
ISNILS(DORB_HEADLESS_GROUPS,[]);
private "_groups";
_groups = DORB_HEADLESS_GROUPS;

_changeHC = {
	private["_temp","_tempID"];
	_temp = DORB_HEADLESS_ALL;
	_tempID = _temp find DORB_HEADLESS_CUR;
	_temp deleteRange [0,_tempID];
	for "_i" from _tempID to ((count DORB_HEADLESS_ALL)-1) do {
		_temp pushBack (DORB_HEADLESS_ALL select _i);
	};
	{
		If ((owner _x)!=0)exitWith {DORB_HEADLESS_CUR = _x;};
	}forEach _temp;
};


{
	private["_cur_group"];
	_cur_group = _x;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}forEach _groups;

_groups = [];

{
	If ((side _x != DORB_PLAYERSIDE)&&{(groupOwner _x) < 3}&&{!(GETVAR(_x,DORB_ISTARGET,false))}) then {
		_groups pushBack _x;
	};
}forEach allGroups;

If (!(DORB_HEADLESS_GROUPS isEqualTo [])) then {
	LOG(FORMAT_2("Gewechselte Gruppen=%1 \n Neue Gruppen = %2",DORB_HEADLESS_GROUPS,_groups));
};

DORB_HEADLESS_GROUPS = _groups;

