/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"

private ["_vehicle","_reppunkt"];

_vehicle= _this select 0;
_reppunkt= _this select 1;
_timemod=4;
_driver = driver _vehicle;





if ((_vehicle isKindOf "ParachuteBase") or (_vehicle isKindOf "Man")) exitWith {};
WaitUntil{_vehicle in list _reppunkt};
sleep 3;
if(!(_vehicle in list _reppunkt)) exitWith {
		//_vehicle vehiclechat "Service abgebrochen"
		
		[[localize "STR_DORB_REP_POINT",localize "STR_DORB_REP_CANCELED"],"dorb_fnc_disp_message",_driver] call BIS_fnc_MP;
	};

_reparry=[];
_vehicle_type = typeOf _vehicle;
_vehicle_HP = configFile >> "cfgvehicles" >> (_vehicle_type) >> "HitPoints";
_vehicle_TR = configFile >> "cfgvehicles" >> (_vehicle_type) >> "NewTurret" >> "HitPoints";

for "_i" from 0 to ((count _vehicle_HP) -1) do {
	_reparry pushBack configName(_vehicle_HP select _i);
};
for "_i" from 0 to ((count _vehicle_TR) -1) do {
	_reparry pushBack configName(_vehicle_TR select _i);
};


/*


for "_i" from 0 to ((count _vehicle_HP) -1) do {
	_text = configName(_vehicle_HP select _i);
	//_text=getText(configFile >> "cfgvehicles" >> (_vehicle_type) >> "HitPoints" >> (configName(_vehicle_HP select _i)) >> "name" ); //>> "name"
	_reparry = _reparry + [configName(_vehicle_HP select _i)];
};

for "_i" from 0 to ((count _vehicle_TR) -1) do {
	_text = configName(_vehicle_TR select _i);
	//_text=(configFile >> "cfgvehicles" >> (_vehicle_type) >> "NewTurret" >> "HitPoints" >> (configName(_vehicle_TR select _i)) >> "name" );
	_reparry = _reparry + [configName(_vehicle_HP select _i)];
};
*/
//hint format ["rep=%1",_reparry];
//sleep 10;
//_reparry = _reparry + ["zbran"];


if !(alive _vehicle) exitWith {};
_treibstoffanzeige = fuel _vehicle;
_vehicle setFuel 0;
[[localize "STR_DORB_REP_POINT",[localize "STR_DORB_REP_EXECUTED",localize "STR_DORB_REP_WAIT"]],"dorb_fnc_disp_info",_driver] call BIS_fnc_MP;
//_vehicle vehicleChat (format ["Der Service wird durchgeführt. Bitte warten...."]);



While {alive _vehicle} do {
	{
		If ((_vehicle getHitPointDamage _x)>0) then {
			_time=(_vehicle getHitPointDamage _x)*10;
			sleep _time;
			_vehicle setHitPointDamage [_x,0];
		};
	}forEach _reparry;
	_vehicle setDamage 0;
	sleep 10;
	_vehicle setVehicleAmmo 1;

	_time = (1-_treibstoffanzeige)*_timemod;
	sleep _time;
	_vehicle setFuel 1;
	
if (true) exitWith {};
};

[[localize "STR_DORB_REP_POINT",localize "STR_DORB_REP_FINISHED"],"dorb_fnc_disp_message",_driver] call BIS_fnc_MP;
/*


While {alive _object} do {
	_object vehicleChat "Rearming...";
	sleep _reload_time;
	_object setVehicleAmmo 1;

	_object vehicleChat "Repairing...";
	sleep _reload_time;
	_object setDamage 0;

	_object vehicleChat "Refueling...";
	sleep _reload_time;
	_f = 0.01;
	while {fuel _object < 0.99} do {
		if(!(_object in list _Rearmlist)) exitWith {_object vehicleChat "Fueling Aborted";	_object setFuel _fuelstore + _f;};
		_object setFuel _fuelstore + _f;
		sleep 0.2;
		_f = _f + 0.01;
	};
	_object vehicleChat format ["%1 is ready...", _Object_name];
	if (true) exitWith {};
};
*/