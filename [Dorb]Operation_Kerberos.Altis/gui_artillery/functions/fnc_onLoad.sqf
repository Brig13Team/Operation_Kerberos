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
    case "ammunitiondata" : {};
    case "orderlist": {
        _ctrl setVariable [QGVAR(orders),((vehicle player) getVariable [QGVAR(orders),[]]) + ((vehicle player) getVariable [QGVAR(localorders),[]])];
    };
    case "artillerydata" : {

        {
            _ctrl lnbAddRow [localize _x,""];
        } forEach [
            LSTRING(artData_X),
            LSTRING(artData_Y),
            LSTRING(artData_Alt),
            LSTRING(artData_Pitch),
            LSTRING(artData_Bank),
            LSTRING(artData_Temp),
            LSTRING(artData_PRES),
            LSTRING(artData_Humid)
        ];

    };
    case "display" : {
        If (isNil QGVAR(handleDisplay)) then {
            GVAR(handleDisplay) = [LINKFUNC(handleDisplay),1,[_ctrl]] call CBA_fnc_addPerFrameHandler;
        };
        GVAR(curArtillery) = vehicle player;
    };
    case "network" : {
        _ctrl cbSetChecked ((vehicle player) getVariable [QGVAR(networkConnected),false]);
    };
    case "networkID" : {
        _ctrl ctrlSetText ((vehicle player) getVariable [QGVAR(networkID),"XX-0000"]);
    };
};
