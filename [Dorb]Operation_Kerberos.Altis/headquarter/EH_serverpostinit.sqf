/*
    Author: Dorbedo

    Description:
        postinit server
*/
#include "script_component.hpp"

GVAR(handles) = HASH_CREATE;
private "_handle";

["medical_onUnconscious", {
    _this params ["_unit", "_status"];
    if ((isplayer _unit)&&(_status)) then {
        [_unit] call FUNC(player_unconscious);
    };
}] call ace_common_fnc_addEventHandler;
/*************************
*
*       waypoints
*
************************/
GVAR(waypoints) = HASH_CREATE;

/*************************
*
*           FDC
*
*************************/
GVAR(FDC) = HASH_CREATE;
HASH_SET(GVAR(FDC),"mortars",[]);
HASH_SET(GVAR(FDC),"artilleries",[]);
HASH_SET(GVAR(FDC),"rockets",[]);
HASH_SET(GVAR(FDC),"firemissions",[]);


_handle = [LINKFUNC(fdc_handle),INTERVALL_FDC,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"fdc_main",_handle);
_handle = [LINKFUNC(fdc_defend_artypos),INTERVALL_SEARCH,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"fdc_defend",_handle);
/*************************
*
*       Anti Air
*
*************************/
GVAR(antiair) = HASH_CREATE;
HASH_SET(GVAR(antiair),"mobile",[]);
HASH_SET(GVAR(antiair),"static",[]);
/*************************
*
*       Headquarter
*
*************************/
GVAR(active) = false;
GVAR(handle) = scriptNull;

/// ressources
GVAR(ressources_amount) = 0;


/// groups - player & ai
GVAR(groups) = HASH_CREATE;
HASH_SET(GVAR(groups),"playergroups",[]);
HASH_SET(GVAR(groups),"defenceGroups",[]);
HASH_SET(GVAR(groups),"patrolGroups",[]);
HASH_SET(GVAR(groups),"attackGroups",[]);
GVAR(playergroups_new) = 0;

/// radars
GVAR(radars) = CREATE_HASH;
HASH_SET(GVAR(radars),"objects",[]);
HASH_SET(GVAR(radars),"targets",[]);

/// dangerzones
GVAR(dangerzones) = HASH_CREATE;
HASH_SET(GVAR(dangerzones),"definitions",[ARR_3(2000,125,16)]);
HASH_SET(GVAR(dangerzones),"gridsize",125);
HASH_SET(GVAR(dangerzones),"distance",2000);

/// Strategy
GVAR(strategy_memory) = HASH_SERIALIZE(GETPRVAR(GVAR(strategy_memory),HASH_CREATE));

/// AttaclPos
GVAR(attackpos) = HASH_CREATE;
HASH_SET(GVAR(attackpos),"Locations",[]);

/// POI
GVAR(POI) = HASH_CREATE;
HASH_SET(GVAR(POI),"locations",[]);

/// Handles
_handle = [LINKFUNC(handle),INTERVALL_HQ,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"main",_handle);
_handle = [LINKFUNC(check_radars),INTERVALL_RADARS,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"radars",_handle);
_handle = [LINKFUNC(handlePlayerGroups),INTERVALL_PLAYERGROUPS,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"playergroups",_handle);
_handle = [LINKFUNC(handleAA),INTERVALL_AA,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"antiair",_handle);


/// Events
[QEGVAR(mission,start_server),{GVAR(active) = true;_this call FUNC(MissionInit);}] call CBA_fnc_addEventHandler;
[QEGVAR(mission,end_server),{GVAR(active) = false;_this call FUNC(MissionCleanUp);}] call CBA_fnc_addEventHandler;
