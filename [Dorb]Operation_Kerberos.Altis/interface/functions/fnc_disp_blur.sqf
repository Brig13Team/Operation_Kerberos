/*
    Author: Dorbedo
    
    Description:
    
    
*/
#include "script_component.hpp"
SCRIPT(disp_blur);
CHECK(isDedicated)
params[["_id","",[""]],["_show",false,[true]]];

if (isnil QGVAR(disp_blur_arr)) then {
    GVAR(disp_blur_arr) = [];
};

if (_show) then {
    GVAR(disp_blur_arr) pushback _id;
    // show blur
    if (isnil QGVAR(disp_blur)) then {
        GVAR(disp_blur) = ppEffectCreate ["DynamicBlur", 102];
        GVAR(disp_blur) ppEffectAdjust [0.9];
        GVAR(disp_blur) ppEffectEnable true;
        GVAR(disp_blur) ppEffectCommit 0;
    };
} else {
    GVAR(disp_blur_arr) = GVAR(disp_blur_arr) - [_id];
    if (GVAR(disp_blur_arr) isEqualTo []) then {
        // hide blur
        if (!isnil QGVAR(disp_blur)) then {
            ppEffectDestroy GVAR(disp_blur);
            GVAR(disp_blur) = nil;
        };
    };
};