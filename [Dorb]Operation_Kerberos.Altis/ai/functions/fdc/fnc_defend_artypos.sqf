/*
	Author: Dorbedo
	
	Description:
		searches Area around artilleriepositions and places Orders
		
*/
#include "script_component.hpp"

private _newcommands = [];
private _searchArea = {
	_this params["_unit","_min","_max","_type"];
	TRACEV_4(_unit,_min,_max,_type);
	private _targetpos = {if (((_x distance _unit)<_max)&&{(GVARMAIN(side) knowsAbout _x)>1})exitwith {getPos _x};[]}forEach allPlayers;
	CHECK(_targetpos isEqualTo [])
	If ((_targetpos distance _unit)>_min) exitwith {_newcommands pushBack [_targetpos,_type,3];};
    
	If (!(GVAR(fdc_rocket) isEqualTo [])) exitwith {_newcommands pushBack [_targetpos,_type,3];};
	If (!(GVAR(fdc_artilleries) isEqualTo [])) exitwith {_newcommands pushBack [_targetpos,_type,3];};
	If (!(GVAR(fdc_logic) isEqualTo [])) exitwith {_newcommands pushBack [_targetpos,_type,3];};
};

GVAR(fdc_mortars) = GVAR(fdc_mortars) select {alive _x};
GVAR(fdc_artilleries) = GVAR(fdc_artilleries) select {alive _x};
GVAR(fdc_rocket) = GVAR(fdc_rocket) select {alive _x};

{[_x,70,850,1] call _searchArea;}forEach _mortars;
{[_x,850,1200,0] call _searchArea;}forEach _artilleries;
{[_x,820,1500,2] call _searchArea;}forEach _rocket;
If (_newcommands isEqualTo []) exitWith {};
{_x call FUNC(fdc_placeOrder);}forEach _newcommands;


