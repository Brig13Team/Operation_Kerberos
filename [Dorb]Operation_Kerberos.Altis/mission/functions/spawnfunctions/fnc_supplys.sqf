/*
 *  Author: Dorbedo
 *
 *  Description:
 *      special spawnfunction for a supply transport
 *
 *  Parameter(s):
 *      0 : ARRAY - the centerpositions
 *
 *  Returns:
 *      ARRAY - Array with the supply wich have to be transported
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_centerpos"];


// spawn the targetvehicle








// spawn the container
private _Units = ["supplys"] call FUNC(spawn_getObjects);
private _objects = [_units] call FUNC(spawn_createAtRescuepoint);


_objects;
//
