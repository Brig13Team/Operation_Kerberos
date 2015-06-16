/*
	Author: Dorbedo
	
	Description:
		Puts Units into City
		Sets up Fortifications
	
	Parameter(s):
		0 : ARRAY			- Position(2D/3D)
		1 : SCALAR			- Radius
		2 : SIDE			- Side of Units
		3 : ARRAY/SCALAR	- Unitcount
			0 : SCALAR		- Min
			1 : SCALAR		- Max
		4 : ARRAY/SCALAR	- Staticcount
			0 : SCALAR		- Min
			1 : SCALAR		- Max
		5 : BOOL			- Fortifications
		6 : BOOL			- IEDs
		7 : BOOL			- Mines
		8 : BOOL			- Civ Vehicles
		
*/
#include "script_component.hpp"

_position = [_this,0,[],[[]],[2,3]] call BIS_fnc_Param;
If (_position isEqualTo []) exitWith {};
_radius = [_this,1,300,[0]] call BIS_fnc_Param;
_side = [_this,2,sideUnknown,[sideUnknown]] call BIS_fnc_Param;
If (_side==sideUnknown) exitWith {};
_unitcount = [_this,3,0,[[],0],[2]] call BIS_fnc_Param;
If (IS_SCALAR(_unitcount)) then {_unit_min=_unitcount;_unit_max=_unitcount;}else{_unit_min=_unitcount select 0;_unit_max=_unitcount select 1;};
_staticount = [_this,4,0,[[],0],[2]] call BIS_fnc_Param;
If (IS_SCALAR(_staticount)) then {_static_min=_staticount;_static_max=_staticount;}else{_static_min=_staticount select 0;_static_max=_staticount select 1;};
_fortifications = [_this,5,false,[true]] call BIS_fnc_Param;
_ieds = [_this,5,false,[true]] call BIS_fnc_Param;
_mines = [_this,5,false,[true]] call BIS_fnc_Param;
_vehicles = [_this,5,false,[true]] call BIS_fnc_Param;


_optionarray = [_unit_min,_unit_max,_static_min,_static_max,_fortifications,_ieds,_mines,_vehicles];


_buildings_unformatted = _position nearObjects ["House", _radius];
//// Format Buildingsarray
_buildings_formatted = [];

for "_i" from 0 to ((count _buildings_unformatted)-1) do {
	/// [typename,pos]
	_buildings_formatted pushBack [typename (_buildings_unformatted select _i),getPosASL(_buildings_unformatted select _i)];
};


/// Roadarray
_roads_formatted = [_position,_radius] call FM(city_roads);

_extensionOutput = "dorb_city" callExtension format["Citydefence,%1,%2",_buildings_formatted,_roads_formatted,_optionarray];

call compile _extensionOutput;

