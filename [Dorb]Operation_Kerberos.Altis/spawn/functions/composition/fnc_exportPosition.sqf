/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports a Position Composition
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

_this params [["_center",[],[[],objNull]],["_radius",35,[0]],["_dir",0,[0]],["_author","BrigTeam",[""]]];

private _hash = [_center,_radius,_author] call FUNC(composition_createFromPosition);
[_hash] call FUNC(composition_exporttohpp);
