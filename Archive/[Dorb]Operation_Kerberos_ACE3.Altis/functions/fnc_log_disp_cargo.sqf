/*
	Author: iJesuz
	
	Description:
		Displays cargo information
		
	Parameter(s):
		0 : OBJECT - vehicle

*/
#include "script_component.hpp"
SCRIPT(log_canload);

params ["_vehicle"];
private ["_gesamtmasse","_leermasse","_ladungsmasse","_leereLadeflaeche", "_logisticStack"];

_gesamtmasse = getMass _vehicle;
_leermasse = _gesamtmasse;

_logisticStack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

{
	{ _leermasse = _leermasse - getMass (_x select 0); } forEach _x;
} forEach _logisticStack;

_ladungsmasse = _gesamtmasse - _leermasse;

if (count _logisticStack > 0) then {
	_leereLadeflaeche = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> ([typeOf _vehicle] call FM(log_getCargoCfg)) >> "max_length");
	{ _leereLadeflaeche = if (_leereLadeflaeche > (_x select 2)) then { _x select 2 } else { _leereLadeflaeche } } forEach (_logisticStack select (count _logisticStack - 1));
} else {
	_leereLadeflaeche = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> ([typeOf _vehicle] call FM(log_getCargoCfg)) >> "max_length");
};


["STR_DORB_LOG_CARGO_INFO",[
	format [localize "STR_DORB_LOG_VEHICLE_MASS",_leermasse],
	format [localize "STR_DORB_LOG_CARGO_MASS",_ladungsmasse],
	format [localize "STR_DORB_LOG_FULL_MASS",_gesamtmasse],
	format [localize "STR_DORB_LOG_COUNT_CARGO",count _logisticStack],
	format [localize "STR_DORB_LOG_FREE_SPACE",_leereLadeflaeche]
],"",false] call FM(disp_info);
