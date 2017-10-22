/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a sandstorm
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

If (isServer) exitWith {
    [QGVAR(sandstorm),[]] call CBA_fnc_globalEvent;
};

CHECK(!hasInterface)

If (!isNil QGVAR(sandstormHandler)) then {
    GVAR(sandstormHandler) = [FUNC(effectSandstorm),1,[]] call CBA_fnc_addPerFrameHandler;
};
