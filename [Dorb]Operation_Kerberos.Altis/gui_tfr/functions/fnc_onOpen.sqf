/*
    Author: Dorbedo

    Description:
    Displays the Groups and their Frequencies

    Requirements:
        called as stacked EH

*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(GVAR(isUpdating))
GVAR(isUpdating) = true;

Private _sel = [];
Private _gruppen=[];
Private _gruppen = [] call FUNC(list_groups);

_sel pushBack [[localize LSTRING(TFR_GROUP),"SR","LR"],[],[]];

for "_i" from 0 to ((count _gruppen)-1) do {
    _var = (leader(_gruppen select _i)) getVariable [QGVAR(frequencies),[0,0]];
    _sel pushBack [[(groupID(_gruppen select _i)),format["%1",(_var select 0)],format["%1",(_var select 1)]],[],[]];
};

lnbClear IDC_TFR_LIST;
lnbAddArray [IDC_TFR_LIST,_sel];

_var = (leader (group player)) getVariable [QGVAR(frequencies),[0,0]];
ctrlSetText [700202, format ["%1",(_var select 0)]];
ctrlSetText [700203, format ["%1",(_var select 1)]];

GVAR(isUpdating) = false;
