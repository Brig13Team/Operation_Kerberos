/*
	Author: iJesuz
	
	Description:
		Displays cargo information
		
	Parameter(s):
		0 : OBJECT - vehicle

*/
#include "script_component.hpp"
SCRIPT(canload);

params ["_vehicle"];
private ["_gesamtmasse","_leermasse","_ladungsmasse","_leereLadeflaeche", "_logisticStack", "_counter"];

_gesamtmasse = getMass _vehicle;
_leermasse = _gesamtmasse;
_counter = 0;

_logisticStack = _vehicle getVariable [QGVAR(stack),[]];

{
	{ _leermasse = _leermasse - getMass (_x select 0); } forEach _x;
} forEach _logisticStack;

_ladungsmasse = _gesamtmasse - _leermasse;

if (count _logisticStack > 0) then {
	_leereLadeflaeche = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle >> "max_length");
	{
		_leereLadeflaeche = if (_leereLadeflaeche > (_x select 2)) then { _x select 2 } else { _leereLadeflaeche };
		INC(_counter);
	} forEach (_logisticStack select (count _logisticStack - 1));
} else {
	_leereLadeflaeche = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle >> "max_length");
};


["STR_DORB_LOG_CARGO_INFO",[
	format [localize LSTRING(VEHICLE_MASS),_leermasse],
	format [localize LSTRING(CARGO_MASS),_ladungsmasse],
	format [localize LSTRING(FULL_MASS),_gesamtmasse],
	format [localize LSTRING(COUNT_CARGO),_counter],
	format [localize LSTRING(FREE_SPACE),_leereLadeflaeche]
],"",false] call EFUNC(interface,disp_info);
