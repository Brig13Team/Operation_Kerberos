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
HASH_SET(GVAR(FDC),"mortars",HASH_CREATE);
HASH_SET(GVAR(FDC),"artilleries",HASH_CREATE);
HASH_SET(GVAR(FDC),"rocket",HASH_CREATE);

_handle = [{_this call FUNC(fdc_handle)},INTERVALL_FDC,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"fdc_main",_handle);
_handle = [{_this call FUNC(fdc_defend_artypos)},INTERVALL_SEARCH,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"fdc_defend",_handle);
/*************************
*
*       Headquarter
*
*************************/
/// radars
GVAR(radars) = CREATE_HASH;
HASH_SET(GVAR(radars),"objects",[]);
HASH_SET(GVAR(radars),"targets",[]);

/// POI
GVAR(dangerzones) = HASH_CREATE;
HASH_SET(GVAR(dangerzones),"definitions",[2000,125,16]);
HASH_SET(GVAR(dangerzones),"gridsize",125);
HASH_SET(GVAR(dangerzones),"distance",2000);

GVAR(strategy_memory) = SERIALIZE(GETPRVAR(GVAR(strategy_memory),HASH_CREATE));



_handle = [FUNC(handle),INTERVALL_HQ,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"main",_handle);
_handle = [FUNC(check_radars),INTERVALL_RADARS,[]] call CBA_fnc_addPerFrameHandler;
HASH_SET(GVAR(handles),"radars",_handle);


GVAR(attackpos) = [];

[
    QEGVAR(mission,startMission),
    {
        _this params [["_centerposition",[],[[]],[2,3]]];
        SETMVAR(GVAR(centerpos),_centerposition);
        EGVAR(headquarter,callIn_airinterception) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "airinterception" >> "amount");
        EGVAR(headquarter,callIn_cas) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "cas" >> "amount");
        EGVAR(headquarter,callIn_motorized) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "motorized" >> "amount");
        EGVAR(headquarter,callIn_armored) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "armored" >> "amount");
        EGVAR(headquarter,callIn_airborne) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "airborne" >> "amount");
        EGVAR(headquarter,callIn_drones) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "armored" >> "amount");
        GVAR(aktive) = true;
    }
] call CBA_fnc_addEventHandler;



[
    QEGVAR(mission,endmission),
    {
        GVAR(aktive) = false;
        {
            deleteLocation _x;
        } forEach GVAR(attackpos);

        SETMVAR(GVAR(Infanterie),[]);
        SETMVAR(GVAR(Attack_Helicopter),[]);
        SETMVAR(GVAR(Transport_Helicopter),[]);
        SETMVAR(GVAR(CAS_Plane),[]);
        SETMVAR(GVAR(Air_other),[]);
        SETMVAR(GVAR(Tank),[]);
        SETMVAR(GVAR(Drone),[]);
        SETMVAR(GVAR(Car),[]);
        SETMVAR(GVAR(marine),[]);
        SETMVAR(GVAR(Other),[]);

        SETMVAR(GVAR(centerpos),[]);
        SETMVAR(GVAR(support_requests),[]);
        SETMVAR(GVAR(buffer),[]);
        [QGVAR(dangerzones)] call EFUNC(common,matrix_clear);
    }
] call CBA_fnc_addEventHandler;

[QEGVAR(mission,endMission)] call CBA_fnc_serverEvent;
