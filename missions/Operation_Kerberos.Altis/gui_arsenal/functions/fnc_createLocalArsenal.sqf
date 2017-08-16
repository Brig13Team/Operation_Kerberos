/*
 *  Author: Dorbedo
 *
 *  Description:
 *      this creates a local arsenal object, whre the items are stored
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      OBJECT - the arsenal object
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
