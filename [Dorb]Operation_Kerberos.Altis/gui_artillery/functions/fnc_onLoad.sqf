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
#define INCLUDE_GUI
#include "script_component.hpp"

_this params [["_type","",[""]],"_ctrl"];

switch _type do {
    case "artillerydata";
    case "ammunitiondata";
    case "orderlist": {
        _ctrl lnbAddRow ["Test","TEst"];
    };
    case "display" : {
        If (isNil QGVAR(handleDisplay)) then {
            GVAR(handleDisplay) = [LINKFUN(handleDisplay),1] call CBA_fnc_addPerFrameHandler;
        };

    };
};
