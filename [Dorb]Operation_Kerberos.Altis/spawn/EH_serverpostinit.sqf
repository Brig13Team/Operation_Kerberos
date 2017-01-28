/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post init
 *
 */
#include "script_component.hpp"

[QEGVAR(mission,prepare),{
    _this call FUNC(createMission);
}] call CBA_fnc_addEventHandler;

[QEGVAR(mission,end),{
    _this call FUNC(onMissionEnding);
}] call CBA_fnc_addEventHandler;

[] call FUNC(Army_set);
