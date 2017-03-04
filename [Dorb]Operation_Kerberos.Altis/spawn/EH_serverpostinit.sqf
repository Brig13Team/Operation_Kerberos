/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post init
 *
 */
#include "script_component.hpp"

GVAR(cleanup_positions) = [];
[QEGVAR(mission,end_server),LINKFUNC(onMissionEnding)] call CBA_fnc_addEventHandler;

[] call FUNC(Army_set);
