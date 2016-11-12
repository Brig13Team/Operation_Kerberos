/*
    Author: Dorbedo

    Description:
    Sets the Groupfrequencies for the squad

*/
#define INCLUDE_GUI
#include "script_component.hpp"

if (leader group player != player) exitWith {
    ["",LSTRING(TFR_NOLEADER)] call EFUNC(gui,message);
};

Private _sel=[];

Private _sr = parseNumber (ctrlText IDC_TFR_EDIT_SR);
Private _lr = parseNumber (ctrlText IDC_TFR_EDIT_LR);
//Private _dd = parseNumber (ctrlText IDC_TFR_EDIT_DD);

_sr = (floor(_sr * 100))/100;
_lr = (floor(_lr * 100))/100;


if ((_sr >=30)&&(_sr <=512)) then {
    _sel pushBack _sr;
}else{
    _sel pushBack 0;
};

if ((_lr >=30)&&(_lr <=87)) then {
    _sel pushBack _lr;
}else{
    _sel pushBack 0;
};
/*
if ((_dd >=32)&&(_dd <=41)) then {
    _sel pushBack _dd;
}else{
    _sel pushBack 0;
};
*/
{
    SETPVAR(_x,GVAR(frequencies),_sel);
}forEach (units (group player));
