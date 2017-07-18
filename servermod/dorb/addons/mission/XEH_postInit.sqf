/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Effects

// [QGVAR(sandstorm),LINKFUNC(obj_createSandstorm)] call CBA_fnc_addEventHandler;

[QGVAR(pickUpSuitcase),{
    [LINKFUNC(handleCarry),15,_this] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
