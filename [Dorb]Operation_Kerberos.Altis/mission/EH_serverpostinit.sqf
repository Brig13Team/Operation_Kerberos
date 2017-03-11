/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Server Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

["missionstest",FUNC(spawn)] call CBA_fnc_addEventHandler;

// initialize rescuemarker
[LINKEFUNC(spawn,cleanup_base) , 900, []] call CBA_fnc_addPerFrameHandler;
If ((getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]) then {
    ERROR("No Rescue-Marker Found")
} else {
    [LINKFUNC(handleRescuePoint), 30, []] call CBA_fnc_addPerFrameHandler;
};

// events
[QGVAR(emp), LINKFUNC(onEMP)] call CBA_fnc_addEventHandler;
[QGVAR(effectDownload_Server), LINKFUNC(obj_effectDownloadServer)] call CBA_fnc_addEventHandler;
[QEGVAR(mission,end_server), LINKFUNC(end)] call CBA_fnc_addEventHandler;
[QFUNC(obj__increaseCounter), LINKFUNC(obj__increaseCounter)] call CBA_fnc_addEventHandler;
[QFUNC(obj__increaseCounterOne), LINKFUNC(obj__increaseCounterOne)] call CBA_fnc_addEventHandler;
[QFUNC(obj__increaseCounterTwo), LINKFUNC(obj__increaseCounterTwo)] call CBA_fnc_addEventHandler;

// initialize missions
[] spawn {
    SCRIPTIN(XEH_SERVERPOSTINIT,mission_init);

    [] call EFUNC(common,setCfgLocations);
    HASH_SET(GVAR(locations),"HQ",(getMarkerPos format [ARR_2("respawn_%1",toLower (str GVARMAIN(playerside)))]));

    GVAR(town) = HASH_GET(GVAR(locations),"city");
    GVAR(industrie) = HASH_GET(GVAR(locations),"industrie");
    GVAR(military) = HASH_GET(GVAR(locations),"military");
    GVAR(water) = HASH_GET(GVAR(locations),"water");
    GVAR(other) = HASH_GET(GVAR(locations),"other");
    GVAR(base) = HASH_GET(GVAR(locations),"HQ");
    // SETMVAR(GVAR(base),[ARR_2("HQ",getMarkerPos format [ARR_2("respawn_%1",toLower (str GVARMAIN(playerside)))])]);

    uiSleep 20;

    [] call FUNC(taskmanager_init);
};
