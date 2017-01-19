/*
    Author: Dorbedo
    Description:
        postinit server
*/
#include "script_component.hpp"
GVARMAIN(debug)=false;

/********************
    Events
********************/

[QGVAR(intel_found),{
    _this params ["_intel"];

    GVAR(found_intel) = GVAR(found_intel) + 1;
    deleteVehicle _intel;
}] call CBA_fnc_addEventHandler;

[QGVAR(weaponcache_destroyed),{
    _this params ["_cache"];

    GVAR(destroyed_caches) = GVAR(destroyed_caches) + 1;
    deleteVehicle _cache;
}] call CBA_fnc_addEventHandler;

[QGVAR(emp),{
    _this params ["_position"];
    private _allVehicles = _position nearEntities [["LandVehicle","Air","Ship_F"],2000];
    {
        switch (true) do {
            case (_x isKindOf 'Air') then {
                private _damagecount = (floor(random 6)) max 1;
                private _hitpoints = ["HitEngine","HitEngine2","HitEngine3","HitBatteries","HitLight","HitHydraulics","HitHStabilizerL1",
                    "HitHStabilizerR1","HitVStabilizer1","HitPitotTube","HitStaticPort","HitStarter1","HitStarter2","HitStarter3",
                    "HitAvionics","HitMissiles"] call BIS_fnc_arrayShuffle;
                {
                    If (_damagecount < 0) exitWith {};
                    private _engine = (vehicle _x) getHitPointDamage "HitEngine";
                    If !(isNil "_engine") then {
                        (vehicle _x) setHitPointDamage ["HitEngine",1];
                        _damagecount = _damagecount - 1;
                    };
                } forEach _hitpoints;
                If (_damagecount > 0) then {
                    (vehicle _x) setFuel 0;
                };
            };
            default {
                private _engine = (vehicle _x) getHitPointDamage "HitEngine";
                If (isNil "_engine") then {
                    (vehicle _x) setFuel 0;
                }else{
                    (vehicle _x) setHitPointDamage ["HitEngine",1];
                };
            };
        };
    } forEach _allVehicles;
    [_position] call EFUNC(tfar_addon,disableTFRArea);
}] call CBA_fnc_addEventHandler;

[QGVAR(hostage_killed),{
    GVAR(killed_hostages) = GVAR(killed_hostages) + 1;
}] call CBA_fnc_addEventHandler;

[QGVAR(hostage_rescued),{
    _this params ["_hostage"];

    GVAR(rescued_hostages) = GVAR(rescued_hostages) + 1;
    deleteVehicle _hostage;
}] call CBA_fnc_addEventHandler;

/********************
    Cleanup
********************/

[LINKEFUNC(spawn,cleanup_base) , 900, [] ] call CBA_fnc_addPerFrameHandler;


/********************
    rescue point
********************/

private _markerpos = getMarkerPos "rescue_marker";
If ((_markerpos distance [0,0,0])>1) then {
    [{
        private _units = (getMarkerPos "rescue_marker") nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 15];
        {
            if (_x getVariable [QGVAR(ISHOSTAGE),false]) then {
                [QGVAR(hostage_rescued),[_x]] call CBA_fnc_globalEvent;
            };
            // [QGVAR(rescuepoint),[_x],_x] call CBA_fnc_localEvent;
        }forEach _units;
    } , 30, [] ] call CBA_fnc_addPerFrameHandler;
};

/********************
    Diag
********************/

/*
[] spawn {
    SCRIPTIN(core,performance);
    while {true} do {
    For "_i" from 0 to 4 do {
        [false,false] call EFUNC(main,debug_performance);
        uisleep 60;
    };
    [true,false] call EFUNC(main,debug_performance);
    uisleep 60;
    false
    };
};
*/

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
