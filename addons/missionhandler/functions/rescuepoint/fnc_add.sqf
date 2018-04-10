#include "script_component.hpp"

/*
  Name: dorb_missionhandler_fnc_rescuepoint_add
  Author: Dorbedo
  adds a rescuepoint

  Arguments:
    0: position <ARRAY/OBJECT/STRING>

  Return Value:
    None

  Public: Yes
*/

params [["_target", [], [[]], [2, 3]], ["_side", west, [west]]];

_target = _target call CBA_fnc_getPos;

If (_target isEqualTo []) exitWith {};

GVAR(rescuepoints) pushBack _target;

nil
