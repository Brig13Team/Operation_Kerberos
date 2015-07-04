/*
	Author: Dorbedo
	
	Description:
		Spawns Mines/IEDs at arraypositions
	
	
	Parameter(s):
		0 : ARRAY	- Spawnpositions
		(Optional)
		1 : ARRAY	- Type of Mines/IEDs (0=AP,1=AT,2=Tripwire,3=IED)
	
	
*/
#include "script_component.hpp"

PARAMS_1(_spawnposarray);
DEFAULT_PARAM(1,_type,0);
CHECK(!IS_ARRAY(_spawnposarray))
Private["_spawnedunit","_spawnedunits","_typ","_gruppe","_dir","_position"];
_ap_mines = ["APERSBoundingMine_Range_Mag","APERSMine_Range_Mag"];
_at_mines = ["ATMine_Range_Mag","SLAMDirectionalMine_Wire_Mag"];
_trip_mines = ["APERSTripMine_Wire_Mag"];
_IED_land = ["IEDLandBig_Remote_Mag","IEDLandSmall_Remote_Mag"];
_IED_urban = ["IEDUrbanBig_Remote_Mag","IEDUrbanSmall_Remote_Mag"];


For "_i" from 0 to ((count _spawnposarray)-1) do {
	_dir = (_spawnposarray select _i)select 3;
	_pos = [(_spawnposarray select _i)select 0,(_spawnposarray select _i)select 1,(_spawnposarray select _i)select 2];
	_triggerConfig = "PressurePlate";
	_triggerSpecificVars = [];
	switch(_type) do {
		case 1: {
				_magazineClass = _at_mines SELRND;
			};
		case 2: {
				_magazineClass = _trip_mines SELRND;
				_triggerConfig = "Tripwire";
			};
		case 3: {
				/// TO DO - choose land or urban mine depending on surrounding area
				_magazineClass = _IED_urban SELRND;
			};
		default {
				_magazineClass = _ap_mines SELRND;
			};
	};

	_magazineTrigger = ConfigFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> _triggerConfig;
	_triggerConfig = ConfigFile >> "ACE_Triggers" >> _triggerConfig;

	_ammo = getText(ConfigFile >> "CfgMagazines" >> _magazineClass >> "ammo");
	if (isText(_magazineTrigger >> "ammo")) then {
		_ammo = getText (_magazineTrigger >> "ammo");
	};
	_triggerSpecificVars pushBack _triggerConfig;

	_explosive = createVehicle [_ammo, _pos, [], 0, "NONE"];
	_explosive setPosATL _pos;
	dorb_side revealMine _explosive;

	[objNull,_explosive,_magazineClass,_triggerSpecificVars] call compile (getText (_triggerConfig >> "onPlace"));
};