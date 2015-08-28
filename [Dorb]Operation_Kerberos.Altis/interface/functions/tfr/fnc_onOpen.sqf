/*
	Author: Dorbedo

	Description:
	Displays the Groups and their Frequencies
	
	Requirements:
		called as stacked EH
	
*/
#include "script_component.hpp"
SCRIPT(tfr_onOpen);
if (GETMVAR(TFR_UPDATE,false)) exitWith {};
private["_sel","_gruppen","_var"];
SETMVAR(TFR_UPDATE,true);
_sel = [];
_gruppen=[];
_gruppen = [] call EFUNC(common,list_groups);

_sel pushBack [[localize "STR_DORB_TFR_GROUP","SR","LR"],[],[]];

for "_i" from 0 to ((count _gruppen)-1) do {	
	_var = (leader(_gruppen select _i)) getVariable [QGVAR(tfr_freq),[0,0]];
	_sel pushBack [[(groupID(_gruppen select _i)),format["%1",(_var select 0)],format["%1",(_var select 1)]],[],[]];
};

lnbClear 700201;
lnbAddArray [700201,_sel];

_var = (leader (group player)) getVariable [QGVAR(tfr_freq),[0,0]];
ctrlSetText [700202, format ["%1",(_var select 0)]];
ctrlSetText [700203, format ["%1",(_var select 1)]];

SETMVAR(TFR_UPDATE,false);