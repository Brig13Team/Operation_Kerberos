/**
 * Author: Dorbedo
 * calculate the muzzlespeed
 *
 * Arguments:
 * 0: <SCALAR> lenght of the barrel
 * 1: <SCALAR> pressure
 * 2: <SCALAR> projectilemass
 *
 * Return Value:
 * <SCALAR> muzzlespeed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_barrellenght","_pressure","_mass"];

private _q = _projectilemass/_crossSectionArea;

private _muzzlespeed = sqrt((2 * _pressure * _barrellenght)/_q);
