/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns a spare track near the player
 *
 *  Parameter(s):
 *      0 : OBJECT - The vehicle, the track was unloaded
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_target"];

private _emptyPosAGL = [_target, "ACE_track", ace_player] call ace_common_fnc_findUnloadPosition;

if (count _emptyPosAGL != 3) exitWith {

};


private _newItem = createVehicle ["ACE_track", _emptyPosAGL, [], 0, ""];
_newItem setPosASL (AGLtoASL _emptyPosAGL);
