/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
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

_this params [["_event","",[""]],["_params",[],[[]]]];


switch (_event) do {
    case "onLoad": {
        _params params ["_dialog"];
        _dialog lbAdd "1 item";
        _dialog lbAdd "2 item";
        _dialog lbAdd "3 item";
        _dialog lbAdd "4 item";
    };
    //cases (insertable by snippet)
};
