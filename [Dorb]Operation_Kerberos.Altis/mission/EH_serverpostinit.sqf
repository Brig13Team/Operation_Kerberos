/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Server Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

/********************
    ServerEvents
********************/
[QGVAR(emp),LINKFUNC(onEMP)] call CBA_fnc_addEventHandler;

[LINKFUNC(objects_handlerRescue), 30, [] ] call CBA_fnc_addPerFrameHandler;

If ((( getMarkerPos "rescue_marker") distance [0,0,0])>1) then {ERROR("No Rescue-Marker Found")};

/********************
    Cleanup
********************/

[LINKEFUNC(spawn,cleanup_base) , 900, [] ] call CBA_fnc_addPerFrameHandler;


/********************
    rescue point
********************/




/********************
    End sidemissions
********************/

[
    "MISSION_ENDSEC",
    {
        _this params [['_event'],'',['']];
        private _val = [GVAR(allTasks),_event] call CBA_fnc_hashGet;
        {
            private _state = [_x] call BIS_fnc_taskState;
            If !(_state in ['CANCELED','SUCCEEDED','FAILED']) then {
                [_x,'CANCELED',false] spawn BIS_fnc_taskSetState;
            };
        } forEach _val;
        nil;
    }
] call CBA_fnc_addEventHandler;

/********************
    Missionloop
********************/

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

//    [] call FUNC(taskmanager_init);

};
