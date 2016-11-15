/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns a predefined composition
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : CONFIG - the composition to spawn
 *      2 : SCALAR - the direction of the composition
 *
 *  Returns:
 *      ARRAY - Position for Missionobjective, empty if none availlible
 *
 */
#include "script_component.hpp"

_this params ["_position","_config","_direction"];

[] call FUNC(delaySpawn);
