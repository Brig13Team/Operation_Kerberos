/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"

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
GVAR(WP_deaktivated) = [];
GVAR(WP_hashes) = [[],0] call CBA_fnc_hashCreate;

/*************************
*
*           FDC
*
*************************/


SETMVAR(GVAR(fdc_mortars),[]);
SETMVAR(GVAR(fdc_artilleries),[]);
SETMVAR(GVAR(fdc_rocket),[]);
SETMVAR(GVAR(fdc_firemissions),[]);
SETMVAR(GVAR(fdc_handle),-1);
SETMVAR(GVAR(fdc_handle_search),-1);

GVAR(fdc_handle) = [
    {
        _this call FUNC(fdc_handle);
    },
    INTERVALL_FDC,
    []
    ] call CBA_fnc_addPerFrameHandler;


GVAR(fdc_handle_search) = [
    {
        _this call FUNC(fdc_defend_artypos);
    },
    INTERVALL_SEARCH,
    []
    ] call CBA_fnc_addPerFrameHandler;

/*************************
*
*       Headquarter
*
*************************/

/// init
GVAR(aktive) = false;
GVAR(definitions) = [2000,125]; // [Radius,size of one field,amount of fields]
GVAR(definitions) pushBack ((GVAR(definitions) select 0)/(GVAR(definitions) select 1));
GVAR(dangerzones) = [(GVAR(definitions) select 2)] call EFUNC(common,matrix_create);


GVAR(mission_handles) = [];
GVAR(mission_handles) pushBack [
    {
        _this call FUNC(handle);
    },
    INTERVALL_HQ,
    []
] call CBA_fnc_addPerFrameHandler;

GVAR(mission_handles) pushBack [
    {
        _this call FUNC(dangerzone_buffer);
    },
    INTERVALL_BUFFER,
    []
] call CBA_fnc_addPerFrameHandler;

GVAR(mission_handles) pushBack [
    {
        _this call FUNC(check_radars);
    },
    INTERVALL_RADARS,
    []
] call CBA_fnc_addPerFrameHandler;

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