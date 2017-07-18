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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_barrellenght","_pressure","_mass"];

private _q = _projectilemass/_crossSectionArea;

private _muzzlespeed = sqrt((2 * _pressure * _barrellenght)/_q);
