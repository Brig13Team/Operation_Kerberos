/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post init
 *
 */
#include "script_component.hpp"

[QEGVAR(mission,start),{
    _this call FUNC(createMissionUnits);
}] call CBA_fnc_addEventHandler;

[QEGVAR(mission,end),{
    _this call FUNC(onMissionEnding);
}] call CBA_fnc_addEventHandler;

[QEGVAR(mission,end),{
    [GVAR(mission,centerPos),2200] call FUNC(cleanup_full);
}] call CBA_fnc_addEventHandler;


GVAR(targetHouses) = [];