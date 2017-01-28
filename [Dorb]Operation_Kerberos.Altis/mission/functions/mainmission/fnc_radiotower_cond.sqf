/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "radiotower" : Conditional Function
 *
 *  Parameter(s):
 *      0 : ARRAY - tower-Objects
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_towers",[],[[]]]];
TRACEV_1(_towers);
private _living_towers = {alive _x} count _towers;
private _testVar = _towers select {alive _x};
TRACEV_2(_living_towers,_testVar);
If (_living_towers < 1) exitWith { "Succeeded" };
""
