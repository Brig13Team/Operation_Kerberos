/*
 *  Author: Dorbedo
 *
 *  Description:
 *      cleans the cargo of an object
 *
 *  Parameter(s):
 *      0 : OBJECT - the object to check
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(canSuspend) exitWIth {
    _this spawn FUNC(cleanCargo);
};

If (!GVAR(isPreloaded)) then {
    [] call FUNC(preload);
};
