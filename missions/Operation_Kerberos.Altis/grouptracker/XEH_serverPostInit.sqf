/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


GVAR(hiddenGroups) = [];

{
    If ((typeOf _x) in ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F"]) then {
        GVAR(hiddenGroups) pushBackUnique (group _x);
    };
} forEach allUnitsUAV;

publicVariable QGVAR(hiddenGroups);
