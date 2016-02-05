/*
    Author: Dorbedo
    
    Description:
        Core function
    
*/
#include "script_component.hpp"


diag_log format["     _fnc_scriptname = %1",_fnc_scriptname];

/// sandstorm
If (isNil QGVAR(sandstormIsActive)) then {GVAR(sandstormIsActive) = false;};
If (hasInterface) then {
    [] spawn FUNC(objects_device_effect_sandstorm_init);
};

GVARMAIN(debug)=false;

CHECK(!isServer)
//CHECK(true)
// Delete dead Units
[{
    If ((count allDead)>20) then {
        private["_allDead","_anzahl"];
        _allDead = allDead;
        _anzahl = floor(((count allDead)/3)*2);
        _allDead resize _anzahl;
        {_x TILGE;}forEach _allDead;
    };
} , 180, [] ] call CBA_fnc_addPerFrameHandler;

/// Cleanup script (small version)
[{[] spawn EFUNC(common,cleanup_small);} , 900, [] ] call CBA_fnc_addPerFrameHandler;


/// Rescue Point;
private["_markerpos"];
_markerpos = getMarkerPos "rescue_marker";
If ((_markerpos distance [0,0,0])>1) then {
    [{
        private "_units";
        _units = (getMarkerPos "rescue_marker") nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 15];
            {
                [QGVAR(rescuepoint),[_x],_x] call EFUNC(events,localEvent);
            }forEach _units;
    } , 30, [] ] call CBA_fnc_addPerFrameHandler;
};


/// Diag
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


[] spawn {
    SCRIPTIN(XEH_POSTINIT,taskloop);

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
