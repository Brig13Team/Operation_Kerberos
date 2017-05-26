/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Server Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// initialize rescuemarker
If ((getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]) then {
    ERROR("No Rescue-Marker Found")
} else {
    [LINKFUNC(handleRescuePoint), 30, []] call CBA_fnc_addPerFrameHandler;
};

// events
[QGVAR(emp), LINKFUNC(obj_spawnEMP)] call CBA_fnc_addEventHandler;
[QGVAR(effectDownload_Server), LINKFUNC(obj_effectDownloadServer)] call CBA_fnc_addEventHandler;
[QEGVAR(mission,end_server), LINKFUNC(end)] call CBA_fnc_addEventHandler;

// rescue point events
[QFUNC(obj__increaseCounter), { _this call FUNC(obj__increaseCounter); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(obj__increaseCounterOne), { _this call FUNC(obj__increaseCounterOne); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(obj__increaseCounterTwo), { _this call FUNC(obj__increaseCounterTwo); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(mainmission_prototype_rescued), { _this call FUNC(mainmission_prototype_rescued); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;

// initialize missions
If ((toUpper worldName) isEqualTo "VR") exitWith {};
[] spawn {
    SCRIPTIN(XEH_SERVERPOSTINIT,mission_init);

    GVAR(taskCounter) = 0;
    [missionConfigFile >> QGVAR(statemachine_Taskmanager)] call CBA_statemachine_fnc_createFromConfig;
    //uiSleep 30;
    uiSleep 5;
    [] call EFUNC(spawn,army_set);
    GVAR(missions) = [HASH_CREATE];
};
