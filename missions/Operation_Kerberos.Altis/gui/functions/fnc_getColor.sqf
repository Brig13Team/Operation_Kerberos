/**
 * Author: Dorbedo
 * returns a colorarray
 *
 * Arguments:
 * 0: <STRING/ARRAY> identfier or color
 *
 * Return Value:
 * <ARRAY> Color array
 *
 */

#include "script_component.hpp"

params [["_color", "", ["", []], [3, 4]]];

If (IS_ARRAY(_color)) exitWith {
    If !(_color isEqualTypeAll 0) exitWith {[""] call FUNC(getColor);};
    _color = _color apply {(_x max 0) min 1};
    If ((count color)<4) then {
        _color set[3, 1];
    };
    _color
};

switch _color do {
    case "red" : {[0.972549, 0, 0, 1]};
    case "green" : {[0.3411764, 0.6509803, 0.2235294, 1]};
    case "blue" : {[0.1333333, 0.4431372, 0.7019607, 1]};
    case "yellow" : {[1, 1, 0, 1]};
    case "randomMetro" : {
        (selectRandom [
                [243, 178, 0, 255],
                [99, 47, 0, 255],
                [0, 193, 63, 255],
                [70, 23, 180, 255],
                [170, 64, 255, 255],
                [145, 209, 0, 255],
                [254, 124, 34, 255],
                [199, 185, 0, 255],
                [176, 30, 0, 255],
                [0, 106, 193, 255],
                [255, 152, 29, 255],
                [31, 174, 255, 255],
                [255, 183, 0, 255],
                [37, 114, 235, 255],
                [193, 0, 79, 255],
                [0, 130, 135, 255],
                [255, 46, 18, 255],
                [86, 197, 255, 255],
                [255, 118, 188, 255],
                [173, 16, 60, 255],
                [144, 0, 172, 255],
                [25, 153, 0, 255],
                [255, 29, 199, 255],
                [0, 216, 204, 255],
                [0, 163, 163, 255]
        ]) apply {_x/255};
    };
    default {[0.917647, 0.9019607, 0.7921568, 1]};
};
