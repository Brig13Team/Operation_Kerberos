/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

[QEGVAR(mission,sandstorm),LINKFUNC(createSandstorm)] call CBA_fnc_addEventHandler;

[QEGVAR(mission,pickUpSuitcase),{
    [LINKFUNC(handleCarry),15,_this] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
