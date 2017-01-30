/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Server Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[LINKEFUNC(spawn,cleanup_base) , 900, [] ] call CBA_fnc_addPerFrameHandler;
[LINKFUNC(objects_handlerRescue), 30, [] ] call CBA_fnc_addPerFrameHandler;
If ((getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]) then {ERROR("No Rescue-Marker Found")};

/********************
    ServerEvents
********************/
[QGVAR(emp),LINKFUNC(onEMP)] call CBA_fnc_addEventHandler;

/********************
    Missionloop
********************/
GVAR(next_mission)  = "";
GVAR(next_location) = [];
GVAR(task_counter)  = 0;
GVAR(conditions)    = [];




[] spawn {
    SCRIPTIN(XEH_SERVERPOSTINIT,taskloop);

    [] call EFUNC(common,setCfgLocations);
    HASH_SET(GVAR(locations),"HQ",(getMarkerPos format [ARR_2("respawn_%1",toLower (str GVARMAIN(playerside)))]));


    GVAR(town) = HASH_GET(GVAR(locations),"city");
    GVAR(industrie) = HASH_GET(GVAR(locations),"industrie");
    GVAR(military) = HASH_GET(GVAR(locations),"military");
    GVAR(water) = HASH_GET(GVAR(locations),"water");
    GVAR(other) = HASH_GET(GVAR(locations),"other");
    GVAR(base) = HASH_GET(GVAR(locations),"HQ");
    //SETMVAR(GVAR(base),[ARR_2("HQ",getMarkerPos format [ARR_2("respawn_%1",toLower (str GVARMAIN(playerside)))])]);

    uiSleep 20;

    [] call FUNC(taskmanager_init);

};
