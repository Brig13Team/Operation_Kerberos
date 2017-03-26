/*
 *  Author: Dorbedo
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
#include "script_component.hpp"

_this params [["_vehicle",objNull,[objNull]],["_fireHash",locationNull,[locationNull]]];

If (isNil QGVAR(artilleryHandle)) then {
    GVAR(artilleryHandle) = [LINKFUNK(handleArtillery),[],[_vehicle]] call CBA_fnc_addPerFrameHandler;
};

GVAR(fireCommands) pushBack _fireHash;
