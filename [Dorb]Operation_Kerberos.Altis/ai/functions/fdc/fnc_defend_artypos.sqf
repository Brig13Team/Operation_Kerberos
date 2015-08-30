/*
	Author: Dorbedo
	
	Description:
		searches Area around artilleriepositions and places Orders
		
*/
#include "script_component.hpp"
SCRIPT(defend_artypos);

If (isNil QGVAR(fdc_logic)) exitwith{
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
	If (!((GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
	If (!((GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
	If (!((GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]))isEqualTo [])) exitwith {
		_newcommands pushBack [_targetpos,_type,3];
	};
};


private["_mortars","_artilleries","_rocket"];
_mortars = GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]);
_artilleries = GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]);
_rocket = GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]);

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
	_x call FUNC(fdc_placeOrder);
}forEach _newcommands;


