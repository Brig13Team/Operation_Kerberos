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

_this params ["_ctrl","_state"];

GVAR(curArtillery) setVariable [QGVAR(networkConnected),_state];

private _netID = GVAR(curArtillery) getVariable GVAR(networkConnected);
If (isNil "_netID") then {
    private _id = format["%1",ceil(random(9998))];
    while {(count _id) < 4} do {
        _id = format["0%1",_id];
    };
    private _id = format["%1-%2",(toString[75,floor(random (25))+65]),_id];

    // if there is already such an artillery registered, then ignore it
    If (GHASH_HASKEY(GVAR(artilleries),_id)) exitWith {};
    GHASH_SET(GVAR(artilleries),_id,GVAR(curArtillery));
};
