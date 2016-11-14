/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onUnload Event
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"


if !(isNil QGVAR(clockPFH)) then {
    [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(clockPFH) = nil;
};
