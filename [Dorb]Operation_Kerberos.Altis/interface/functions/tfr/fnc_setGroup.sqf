/*
    Author: Dorbedo

    Description:
    Sets the Groupfrequencies for the squad

*/
#include "script_component.hpp"
SCRIPT(setGroup);
private["_sel","_sr","_lr","_dd"];

if (leader group player != player) exitWith {hint localize LSTRING(TFR_NOLEADER);};

_sel=[];

_sr = parseNumber (ctrlText 700205);
_lr = parseNumber (ctrlText 700206);
//_dd = parseNumber (ctrlText 700207);

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
    SETPVAR(_x,GVAR(tfr_freq),_sel);
}forEach (units (group player));