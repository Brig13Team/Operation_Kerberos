/*
	Author: Dorbedo
	
	Description:
		searches Area around artilleriepositions and places Orders
		
*/
#include "script_component.hpp"
SCRIPT(fdc_defend_artypos);

If (isNil "DORB_FDC_LOGIC") exitwith{
	[_this select 1] call CBA_fnc_removePerFrameHandler;
};

private ["_searchArea","_newcommands"];
_newcommands = [];

_searchArea = {
	params["_unit","_min","_max","_type"];
	private "_targetpos";
	_targetpos = 
	{
		if ((_x distance _unit)<_max) exitwith {getPos _x};
		[]
	}forEach allPlayers;
	CHECK(_targetpos isEqualTo [])
	If ((_targetpos distance _unit)>_min) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
	If (!((GETVAR(DORB_FDC_LOGIC,DORB_FDC_ROCKET,[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
	If (!((GETVAR(DORB_FDC_LOGIC,DORB_FDC_ARTILLERIES,[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
	If (!((GETVAR(DORB_FDC_LOGIC,DORB_FDC_MORTARS,[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
};


private["_mortars","_artilleries","_rocket"];
_mortars = GETVAR(DORB_FDC_LOGIC,DORB_FDC_MORTARS,[]);
_artilleries = GETVAR(DORB_FDC_LOGIC,DORB_FDC_ARTILLERIES,[]);
_rocket = GETVAR(DORB_FDC_LOGIC,DORB_FDC_ROCKET,[]);

If ((_mortars isEqualTo [])&&(_artilleries isEqualTo [])&&(_rocket isEqualTo [])) exitwith {
	[_this select 1] call CBA_fnc_removePerFrameHandler;
};

{
	[_x,70,850,1] call _searchArea;
}forEach _mortars;
{
	[_x,850,1200,0] call _searchArea;
}forEach _artilleries;
{
	[_x,820,1500,2] call _searchArea;
}forEach _rocket;

{
	_x call FM(fdc_placeOrder);
}forEach _newcommands;


