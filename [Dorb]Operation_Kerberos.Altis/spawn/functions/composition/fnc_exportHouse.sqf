/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports a houseComposition
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

_this params [["_house",objNull,[objNull]],["_radius",35,[0]],["_author","BrigTeam",[""]]];

private _hash = [_house,_radius,_author] call FUNC(composition_createFromHouse);
[_hash] call FUNC(composition_exporttohpp);
