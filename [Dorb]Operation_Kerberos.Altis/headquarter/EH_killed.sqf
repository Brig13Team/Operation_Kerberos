/*
 *  Author: Dorbedo
 *
 *  Description:
 *      killed Events
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If (isServer) then {
    ["CAManBase", "killed", {_this call FUNC(onKilled);},true,[],true] call CBA_fnc_addClassEventHandler;
};
