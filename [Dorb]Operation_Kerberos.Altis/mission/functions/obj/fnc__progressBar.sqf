/*
 *  Author: iJesuz
 *
 *  Description:
 *      Create ACE-Progressbar on target
 *
 *  Parameter(s):
 *      0 : OBJECT  - target
 *      1 : CODE    - function to be called
 *      2 : STRING  - text to be displayed
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_target", "_code", "_string"];

[
    5,
    [_target],
    _code,
    {},
    localize _string
] call ace_common_fnc_progressBar;
