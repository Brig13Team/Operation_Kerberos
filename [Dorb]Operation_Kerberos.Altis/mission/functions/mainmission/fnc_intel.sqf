/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "intel"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setPos ((getPos _x) vectorAdd [0,0,1]);
} forEach _targets;

//[_mission, _targets] call FUNC(mainmission__oneCounter);
