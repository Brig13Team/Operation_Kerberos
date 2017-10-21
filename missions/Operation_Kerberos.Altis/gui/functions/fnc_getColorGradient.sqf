/**
 * Author: Dorbedo
 * returns the color based on the proces (red->yellow->green)
 *
 * Arguments:
 * 0: <SCALAR> Current Value
 * 1: <SCALAR> Min Value
 * 2: <SCALAR> Max Value
 *
 * Return Value:
 * <ARRAY> the color array
 *
 */

#include "script_component.hpp"

params [
    ["_value", 0, [0]],
    ["_value_min", 0, [0]],
    ["_value_max", 1, [0]]
];

If ((_value_max - _value_min) <=0) exitWith {[0, 0, 0, 0]};

private _share = _value / (_value_max - _value_min);

private _red = If (_share >= 0.5) then {
    1-((_share-0.5)/0.5)
} else {
    1
};
private _green = If (_share <= 0.5) then {
    _share/0.5
} else {
    1
};

// modify the colors to be not to loud
[
    _red * 0.6 + 0.2,
    _green * 0.6 + 0.2,
    0,
    1
];
