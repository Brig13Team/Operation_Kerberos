#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_statemachine_cancelALL
 *
 * Author: Dorbedo
 * cancels all missions
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

{
    _x setVariable ['progress','cancel'];
} forEach GVAR(missions);
