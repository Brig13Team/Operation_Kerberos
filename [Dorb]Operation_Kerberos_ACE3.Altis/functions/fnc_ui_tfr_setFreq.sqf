/*
	Author: Dorbedo

	Description:
	Sets the Frequencies of the Squad to your radio
	
*/
#include "script_component.hpp"
private["_sr","_lr"];
_sr = parseNumber (ctrlText 700202);
_lr = parseNumber (ctrlText 700203);


if ((_sr >=30)&&(_sr <=512)&&( call TFAR_fnc_haveSWRadio)) then {
	[(call TFAR_fnc_activeSwRadio), format["%1",_sr]] call TFAR_fnc_setSwFrequency;
};

if ((_lr >=30)&&(_lr <=87)&&( call TFAR_fnc_haveLRRadio)) then {
	format["%1",_lr] call TFAR_fnc_setLongRangeRadioFrequency;
};


