/**
 * Author: Dorbedo
 * displays the possible boxes
 *
 * Arguments:
 * 0: <ARRAY> position
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_position"];

private _nearObjects = nearestObjects [_position, ["AllVehicles"], _check_radius];

// filter the Objects

//TODO


// create the list
private _list = [] append {_nearObjects}
