/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if a doorcharge can be placed
 *
 *  Parameter(s):
 *      0 : OBJECT - House
 *      1 : SCALAR - Doornumber
 *
 *  Returns:
 *      BOOL - the charge can be placed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_house","_caller","_door"];
_door = _door select 0;

((_house animationPhase (_door + "_rot")) < 0.1)
&&{
    ("DemoCharge_Remote_Mag" in (magazines _caller))||
    ("rhsusf_m112_mag" in (magazines _caller))
}
