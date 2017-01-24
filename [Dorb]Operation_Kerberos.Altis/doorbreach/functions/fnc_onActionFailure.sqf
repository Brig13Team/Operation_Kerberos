/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onActionFailed
 *
 *  Parameter(s):
 *      0 : OBJECT - house
 *      1 : OBJECT - caller
 *      2 : STRING - Animation
 *
 *  Returns:
 *     none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_house","_caller","_door"];

_house setVariable [format[QGVAR(%1),_door],nil,true];

_caller addMagazineCargoGlobal ["DemoCharge_Remote_Ammo",1];
