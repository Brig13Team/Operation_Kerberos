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

["CAManBase", "Killed", {_this spawn FUNC(onKilled);},true,[],true] call CBA_fnc_addClassEventHandler;
