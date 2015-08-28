/*
	Author: Dorbedo
	
	Description:
		Repairpoint
		
	Parameter(s):
		0 : STRING	- Modus
		
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(repairpoint);
PARAMS_4(_target,_caller,_id,_arguments);


Private["_vehicle","_timemod"];
_vehicle = vehicle _caller;


_timemod = 4;


/// recheck (obsolet)

CHECK((_vehicle isKindOf "ParachuteBase")or(_vehicle isKindOf "Man"))
_reppos = getPos _vehicle;
_abgebrochen = true;
While {((vehicle _caller == _vehicle)&&(alive _vehicle)&&(((getPos _vehicle)distance _reppos)<=1))} do {
	
	["STR_DORB_REP_POINT",["STR_DORB_REP_EXECUTED","STR_DORB_REP_WAIT"]] call EFUNC(interface,disp_info);
	
	_treibstoffmenge = fuel _vehicle;
	_vehicle setFuel 0;
	
	/// Repair
	_vehicle_type = typeOf _vehicle;
	_hitpoints = [];
	_hitpoints = ["Hitpoints",(configfile >> "CfGVehicles" >> _vehicle_type)] call FUNC(get_cfg_subclasses);
	
	{
		while {(_vehicle getHit (getText(_x >> "name")))>0} do {
			_olddmg = (_vehicle getHit (getText(_x >> "name")));
			_newdmg = 0;
			If (_olddmg > 0.1) then  {
				_newdmg = _olddmg - 0.1;
			};
			uisleep (_timemod*0.5);
			_vehicle setHit [(getText(_x >> "name")),_newdmg];
		};
	}forEach _hitpoints;
	_vehicle setDamage 0;
	
	
	/// Rearm
	
	
	_turrets = [_vehicle_type,[]] call BIS_fnc_getTurrets;
	
	/*
	vehicle addMagazineTurret [magazineName, []];

	unitName addMagazine [magazineName, ammoCount]
	*/
	uisleep (_timemod * 2 * (count _turrets));
	_vehicle setVehicleAmmo 1;
	
	/// Refuel
	_vehicle setFuel _treibstoffmenge;
	
	for [{_i= _treibstoffmenge},{_i <= 1},{_i = _i + 0.01}] do {
		_vehicle setFuel _i;
		uisleep 0.25;
	};
	_vehicle setFuel 1;
	
	
	_abgebrochen=false;
	CHECK(true)
};

If (_abgebrochen) exitWith {
	["STR_DORB_REP_POINT","STR_DORB_REP_CANCELED"] call EFUNC(interface,disp_message);
};

["STR_DORB_REP_POINT","STR_DORB_REP_FINISHED"] call EFUNC(interface,disp_message);