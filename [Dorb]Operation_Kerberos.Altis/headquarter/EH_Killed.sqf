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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

["CAManBase", "Killed", {
    If (!(local (_this select 0))) exitWith {
        TRACE("Unit not local");
        TRACEV_1(_this);
    };
    _this spawn FUNC(onKilled);
},true,[],true] call CBA_fnc_addClassEventHandler;
