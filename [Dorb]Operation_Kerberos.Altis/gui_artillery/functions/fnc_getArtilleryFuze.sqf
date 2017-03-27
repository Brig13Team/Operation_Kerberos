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


_this params [["_ammotype","",["",0]]];


If (_ammotype isEqualType 0) then {
    [

    ] select _fuze;
}else{
    private _fuze = switch (_ammotype) do {
        default {[0,LSTRING(FUZE_0)]};
    };
    [_fuze] call FUNC(getArtilleryFuze);
};
