/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"

/********************
    Events
********************/

[QGVAR(emp),{
    _this params ["_position"];
    private _allVehicles = _position nearEntities [["LandVehicle","Air","Ship_F"],2000];
    {
        switch (true) do {
            case (_x isKindOf 'Air') then {
                private _damagecount = (floor(random 4)) max 1;
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
}] call EFUNC(events,addEventHandler);

/********************
    Cleanup
********************/
[{
    If ((count allDead)>20) then {
        private _allDead = allDead;
        private _anzahl = floor(((count allDead)/3)*2);
        _allDead resize _anzahl;
        {_x TILGE;}forEach _allDead;
    };
} , 180, [] ] call CBA_fnc_addPerFrameHandler;

[{[] spawn EFUNC(common,cleanup_small);} , 900, [] ] call CBA_fnc_addPerFrameHandler;


/********************
    rescue point
********************/

private _markerpos = getMarkerPos "rescue_marker";
If ((_markerpos distance [0,0,0])>1) then {
    [{
        private _units = (getMarkerPos "rescue_marker") nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 15];
            {
                [QGVAR(rescuepoint),[_x],_x] call EFUNC(events,localEvent);
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
    Missionloop
********************/

[] spawn {
    SCRIPTIN(XEH_SERVERPOSTINIT,taskloop);

    private _aufgabennummer=0;
    private _return = [] call EFUNC(common,get_cfglocations);
    SETMVAR(GVAR(town),(_return select 0));
    SETMVAR(GVAR(industrie),(_return select 1));
    SETMVAR(GVAR(military),(_return select 2));
    SETMVAR(GVAR(water),(_return select 3));
    SETMVAR(GVAR(other),(_return select 4));

    [] call EFUNC(headquarter,init);

    uisleep 20;

    for "_u" from 0 to 120 do {
        uisleep 5;
        INC(_aufgabennummer);
        TRACEV_1(_aufgabennummer);
        [FORMAT_1("MAINTASK_%1",_aufgabennummer)] call FUNC(choose_main);
    };
    ERROR("CORE LOOP CRASHED");
    endMission "End1";
};
