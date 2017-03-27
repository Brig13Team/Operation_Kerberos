/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _state = GVAR(curArtillery) getVariable [QGVAR(state),0];

TRACEV_1(_state);

If (_state < 2) exitWith {};

private _gunner = gunner GVAR(curArtillery);
TRACEV_2(_gunner);
_gunner fireAtTarget [objNull];

GVAR(curArtillery) setVariable [QGVAR(state),1];
