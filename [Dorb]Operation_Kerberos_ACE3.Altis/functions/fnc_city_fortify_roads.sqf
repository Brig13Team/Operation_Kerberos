/*
	Author: Dorbedo
	
	Description:
		
		- Weights the Roads, selects important Roadpositions,
		- sends Veh-Patrols,Inf-Patrols
		
	
	Parameter(s):
		0 : ARRAY		- formatted Road-Array
		1 : ARRAY or BOOL	- (true) for automatic or the unique amounts [patrols,fortifications,ieds]
		2 : BOOL			- spawn Fortifications
		3 : BOOL			- spawn IEDs
		4 : BOOL			- spawn Civ-Vehicles
		5 : BOOL			- spawn Trash
		
	Returns:
		BOOL
	/// TO DO: make extension
*/
#include "script_component.hpp"
/// amounts: [patrols,fortifications,ieds]
params[["_roadArray",[],[[]]],["_amounts",[0,0,0],[[],true],[3]],["_fortifications",false,[true]],["_IEDs",false,[true]],["_civVehicles",false,[true]],["_trash",false,[true]]];

/// Exit if there is no roadarray or all options are turned off
CHECK(_roadArray isEqualTo [])
CHECK(!(_fortifications||_IEDs||_civVehicles||_trash)
If ((IS_ARRAY(_amounts))&&{(((_amounts select 0)==0)&&((_amounts select 1)==0)&&((_amounts select 2)==0)))}) exitWith {};
If ((IS_BOOL(_amounts))&&{!_amounts}) exitWith {};

/// Set Amounts
_roadcount = count _roadArray;

/// only 33% of the roads should have something
_max_amount = floor(_roadCount/3) max 1;
CHECK(_max_amount <= 2)


If (IS_ARRAY(_amounts)) then {
	_amount = 0;
	If (_amounts select 0 > 0) then {_amount = _amount + _amounts select 0;};
	If (_amounts select 1 > 0) then {_amount = _amount + _amounts select 1;};
	If (_amounts select 2 > 0) then {_amount = _amount + _amounts select 2;};

	/// If there are not enough roads the amounts are reduced. The automatic function is ignored
	If (_amount > _max_amount) then {
		If (_amounts select 0 > 0) then {_amounts set [0,(((_amounts select 0)/_amount)*(_max_amount))];}else{_amounts set [0,0];};
		If (_amounts select 1 > 0) then {_amounts set [1,(((_amounts select 1)/_amount)*(_max_amount))];}else{_amounts set [1,0];};
		If (_amounts select 2 > 0) then {_amounts set [2,(((_amounts select 2)/_amount)*(_max_amount))];}else{_amounts set [2,0];};
	};
}else{
	private["_count_IEDs","_count_fortifications","_count_patrols"];
	_count_fortifications = ((floor(_max_amount/4)) min 7) max 1;
	_count_IEDs = ((floor(_max_amount/3))min 20) max 1;
	_count_patrols = (floor(_max_amount - _count_IEDs - _count_fortifications)) max 0;
	_amounts = [_count_patrols,_count_fortifications,_count_IEDs];
};










