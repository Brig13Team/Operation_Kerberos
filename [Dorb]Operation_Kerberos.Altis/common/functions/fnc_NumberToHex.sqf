/*
 *  Author: Dorbedo
 *
 *  Description:
 *      converts a number to a HEX
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_number",0,[0]]];

_number = floor _number;

private _return = [];

while {_number > 0} do {
    private _rest = _number mod 16;
    TRACEV_2(_number,_rest);
    _return pushBack (switch (_rest) do {
        case 10 : {"a"};
        case 11 : {"b"};
        case 12 : {"c"};
        case 13 : {"d"};
        case 14 : {"e"};
        case 15 : {"f"};
        default {str _rest;};
    });
    _number = floor (_number / 16);

};

reverse _return;
("0x" + (_return joinString ""))
