/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post init
 *
 */
#include "script_component.hpp"


[QEGVAR(mission,end),{
    _this call FUNC(onMissionEnding);
}] call CBA_fnc_addEventHandler;
