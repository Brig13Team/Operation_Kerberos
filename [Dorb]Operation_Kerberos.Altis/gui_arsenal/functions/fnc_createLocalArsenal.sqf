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


private _newBox = "Land_Pallet_MilBoxes_F" createVehicleLocal [0,0,0];
_newBox enableSimulation false;
_newBox allowDammage false;
_newBox hideObject true;
_newBox setPos [-10000,-10000,-10000];

_newBox;
