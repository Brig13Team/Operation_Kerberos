/**
 * Author: Dorbedo
 * blurs the display - used for dialogs
 *
 * Arguments:
 * 0: <STRING> the id of the blur effect
 * 1: <BOOL> show the blur
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

If !(hasInterface) exitWith {};

params [
    ["_id", "", [""]],
    ["_show", false, [true]]
];

If (_show) then {
    GVAR(blur_arr) pushBack _id;
    if (isnil QGVAR(blur)) then {
        GVAR(blur) = ppEffectCreate ["DynamicBlur", 102];
        GVAR(blur) ppEffectAdjust [0.9];
        GVAR(blur) ppEffectEnable true;
        GVAR(blur) ppEffectCommit 0;
    };
} else {
    GVAR(blur_arr) = GVAR(blur_arr) - [_id];
    if (GVAR(blur_arr) isEqualTo []) then {
        if (!isnil QGVAR(blur)) then {
            ppEffectDestroy GVAR(blur);
            GVAR(blur) = nil;
        };
    };
};
