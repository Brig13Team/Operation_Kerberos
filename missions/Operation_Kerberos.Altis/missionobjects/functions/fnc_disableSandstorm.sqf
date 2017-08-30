/*
 *  Author: Dorbedo
 *
 *  Description:
 *      disables the sandstorm
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isServer) exitWith {
    GVAR(sandstormIsActive) = false;
    publicVariable QGVAR(sandstormIsActive);
};

GVAR(sandstormIsActive) = false;
