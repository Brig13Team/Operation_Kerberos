/**
 * Author: Dorbedo
 * creates a House-Composition in a near House and returns the spawnpositions for MissionObjects
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <SCALAR> radius to search in
 *
 * Return Value:
 * <ARRAY> Array with positions
 *
 */

#include "script_component.hpp"

params [
    ["_centerposition",[],[[]],[2,3]],
    ["_radius",200,[0]]
];

// TODO: this just returns something for the other component

[(_centerposition getPos [random _radius, random 360])]
