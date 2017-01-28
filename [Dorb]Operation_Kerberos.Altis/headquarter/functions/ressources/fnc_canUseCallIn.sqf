/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks if you can use a callIn attack
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - allowed to callIn
 *
 */
#include "script_component.hpp"

_this params [["_type","",[""]]];

switch (_type) do {
    case "airinterception" : {
        true;
    };
    case "helicopter" : {
        true;
    };

    default {[] call FUNC(CanCallInUnits);};
};
