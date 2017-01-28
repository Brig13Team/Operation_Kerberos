/*
 *  Author: Dornbedo
 *
 *  Description:
 *      Mission "Hostage" : Conditional Function
 *
 *  Parameter(s):
 *      0 : NUMBER - number of prototypes to be found
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_prototype",-1,[0]]];

if ((GVAR(killed_prototype) + GVAR(rescued_prototype)) < _prototype) exitWith { "" };

if (GVAR(rescued_prototype) > _prototype*0.66) exitWith { "Succeeded" };
if (GVAR(killed_prototype) >= _prototype*0.66) exitWith { "Failed" };

"Canceled"
