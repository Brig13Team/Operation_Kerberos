/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Intel"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

[_mission, {
    // nothing todo (intel is initialized via EH_clientPostInit)
}] call FUNC(mainmission__oneCounter);
