/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Post Init Header
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

[
    QGVAR("addMessage"),
    {_this call FUNC(addMessage);}
] call CBA_fnc_addEventHandler;
