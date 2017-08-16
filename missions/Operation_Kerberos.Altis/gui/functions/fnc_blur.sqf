/*
 *  Author: Dorbedo
 *
 *  Description:
 *      burs the display of a user
 *
 *  Parameter(s):
 *      0 : STRING - ID of the blur effect
 *      1 : BOOL - show
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

CHECK(!hasInterface)
_this params[["_id","",[""]],["_show",false,[true]]];

if (isnil QGVAR(blur_arr)) then {
    GVAR(blur_arr) = [];
};

if (_show) then {
    GVAR(blur_arr) pushback _id;
    // show blur
    if (isnil QGVAR(blur)) then {
        GVAR(blur) = ppEffectCreate ["DynamicBlur", 102];
        GVAR(blur) ppEffectAdjust [0.9];
        GVAR(blur) ppEffectEnable true;
        GVAR(blur) ppEffectCommit 0;
    };
} else {
    GVAR(blur_arr) = GVAR(blur_arr) - [_id];
    if (GVAR(blur_arr) isEqualTo []) then {
        // hide blur
        if (!isnil QGVAR(blur)) then {
            ppEffectDestroy GVAR(blur);
            GVAR(blur) = nil;
        };
    };
};
