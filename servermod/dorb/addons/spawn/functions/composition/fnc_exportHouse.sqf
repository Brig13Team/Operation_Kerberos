/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports a houseComposition
 *
 *  Parameter(s):
 *      0 : OBJECT - the house
 *      1 : SCALAR - Radius
 *      2 : STRING - author
 *
 *  Returns:
 *      none
 *
 *   [cursorTarget,30] call dorb_spawn_fnc_composition_exportHouse;
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_house",objNull,[objNull]],["_radius",35,[0]],["_author","BrigTeam",[""]]];

private _hash = [_house,_radius,_author] call FUNC(composition_createFromHouse);
[_hash] call FUNC(composition_exporttohpp);
