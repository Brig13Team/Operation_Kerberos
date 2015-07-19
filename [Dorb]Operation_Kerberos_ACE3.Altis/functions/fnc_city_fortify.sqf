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
		
		
		[_position,300,dorb_side,40,15,true,true,true,true] spawn dorb_fnc_city_fortify
		
*/
#include "script_component.hpp"

params[
	["_position",[],[[]],[2,3]],
	["_radius",300,[0]],
	["_side",sideUnknown,[west]],
	["_unitcount",0,[[],0],[2]],
	["_staticcount",0,[[],0],[2]],
	["_fortifications",false,[true]],
	["_ieds",false,[true]],
	["_mines",false,[true]],
	["_civvehicles",false,[true]]
	];
If ((_position isEqualTo [])||(_side==sideUnknown)) exitWith {false};
//If (IS_SCALAR(_unitcount)) then {
	_unit_min=_unitcount;
	_unit_max=_unitcount;
/*}else{
	_unit_min=_unitcount select 0;
	_unit_max=_unitcount select 1;
};
If (IS_SCALAR(_staticcount)) then {*/
	_static_min=_staticcount;
	_static_max=_staticcount;/*
}else{
	_static_min=_staticcount select 0;
	_static_max=_staticcount select 1;
};*/
//LOG_2(_unitcount,_staticcount);
//LOG_8(_unit_min,_unit_max,_static_min,_static_max,_fortifications,_ieds,_mines,_civvehicles);
_optionarray = [_unit_min,_unit_max,_static_min,_static_max,_fortifications,_ieds,_mines,_civvehicles];
//LOG_1(_optionarray);
_buildings_unformatted = _position nearObjects ["House", _radius];
//// Format Buildingsarray
_buildings_formatted = [];

for "_i" from 0 to ((count _buildings_unformatted)-1) do {
	/// [typename,pos]
	_buildings_formatted pushBack [typeOf  (_buildings_unformatted select _i),getPosASL(_buildings_unformatted select _i),getDir(_buildings_unformatted select _i)];
};

/// Roadarray
_roads_formatted = [_position,_radius] call FM(city_roads);




//// Generate + spawn

// Roads (fortifications, IED, Inf Patrols, roadside-civ veh)
[_roads_formatted,true,_fortifications,_ieds,_civvehicles,_ieds] call FM(city_fortify_roads);

// Buildings 

[_buildings_formatted,_optionarray]call FM(city_fortify_buildings);

/*
_extensionOutput = "dorb_city" callExtension format["Citydefence,%1,%2",_buildings_formatted,_roads_formatted,_optionarray];

call compile _extensionOutput;
*/
_return = [(count _buildings_formatted),(count _roads_formatted)];
_return

