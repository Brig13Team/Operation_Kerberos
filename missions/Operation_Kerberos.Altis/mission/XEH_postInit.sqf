/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!((getMissionConfigValue ["isKerberos", 0]) > 0))

[QGVAR(pickUpSuitcase),{
    [LINKFUNC(handleCarry),15,_this] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
