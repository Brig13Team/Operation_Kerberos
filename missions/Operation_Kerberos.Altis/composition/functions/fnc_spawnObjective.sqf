/**
 * Author: Dorbedo
 * creates a mission Objective
 *
 * Arguments:
 * 0: <ARRAY> centerposition
 * 1: <STRING> missiontype
 * 2: <BOOL> return only position (default: true)
 *
 * Return Value:
 * <ARRAY> return Positions/Objectives
 *
 */

#include "script_component.hpp"

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_type", "", [""]],
    ["_onlyPos", true, [true]]
];



