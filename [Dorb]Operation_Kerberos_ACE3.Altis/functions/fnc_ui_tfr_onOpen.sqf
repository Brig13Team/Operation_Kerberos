/*
    Author: Dorbedo

    Description:
    Displays the Groups and their Frequencies

    Requirements:
        called as stacked EH

*/
#include "script_component.hpp"
if (GETMVAR(TFR_UPDATE,false)) exitWith {};
private["_sel","_gruppen","_var"];
SETMVAR(TFR_UPDATE,true);
_sel = [];
_gruppen=[];
_gruppen = [] call FM(list_groups);

_sel pushBack [[localize "STR_DORB_TFR_GROUP","SR","LR"],[],[]];

for "_i" from 0 to ((count _gruppen)-1) do {
    _var = (_gruppen select _i) getVariable ["DORB_TFR",[0,0]];
    _sel pushBack [[format["%1",((_gruppen select _i) getVariable ["DORB_GPTR_NAME",(groupID(_gruppen select _i))])],format["%1",(_var select 0)],format["%1",(_var select 1)]],[],[]];
};

lnbClear 700201;
lnbAddArray [700201,_sel];

_var = (group player) getVariable ["DORB_TFR",[0,0]];
ctrlSetText [700202, format ["%1",(_var select 0)]];
ctrlSetText [700203, format ["%1",(_var select 1)]];

SETMVAR(TFR_UPDATE,false);