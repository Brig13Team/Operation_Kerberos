/*
    Author: Dorbedo

    Description:
        The FDC - Logic
        coordinates artilleryfire, sends firemissions, tries to defend artillery sites

    Parameter(s):
        0 : ARRAY   - params
        1 : SCALAR  - Handle

*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!GVAR(active))

If (HASH_GET(GVAR(FDC),"firemissions") isEqualTo []) exitWith {
    //TRACE("no firemissions");
};
private _current_firemission = HASH_GET(GVAR(FDC),"firemissions") deleteAt 0;
_current_firemission params ["_position","_type","_shelltype","_amount"];
TRACEV_4(_position,_type,_shelltype,_amount);
HASH_SET(GVAR(FDC),"artilleries",(HASH_GET(GVAR(FDC),"artilleries") select {alive _x}));
HASH_SET(GVAR(FDC),"mortars",(HASH_GET(GVAR(FDC),"mortars") select {alive _x}));
HASH_SET(GVAR(FDC),"rockets",(HASH_GET(GVAR(FDC),"rockets") select {alive _x}));

private _current_artillerys_array = switch(_type) do {
    case 0 : {HASH_GET(GVAR(FDC),"artilleries") call BIS_fnc_arrayShuffle};
    case 1 : {HASH_GET(GVAR(FDC),"mortars") call BIS_fnc_arrayShuffle};
    case 2 : {HASH_GET(GVAR(FDC),"rockets") call BIS_fnc_arrayShuffle};
    default {[]};
};

If (_current_artillerys_array isEqualTo []) exitwith {
    TRACE_1("No artilleryunit found for Mission: \n %1",_current_firemission);
};

private _minDistance = switch (_type) do {
    case 0 : {1026};//1026
    case 1 : {560};
    case 2 : {800};
    default {1050};
};;


_current_artillerys_array = _current_artillerys_array select {
    (_position inRangeOfArtillery [[_x],_shelltype])
    &&((_position distance _x)>_minDistance)
    &&(_shelltype in getArtilleryAmmo[_x])
};

If (_current_artillerys_array isEqualTo []) exitwith {
    _type = [1,-1,0] select _type;
    If (_type >= 0) then {
        TRACE("No Artillery in Range - switching to lower artillery class");
        [_position,_type,_amount] call FUNC(fdc_placeOrder);
    } else {
        TRACE("No Artillery in Range - deleting Order");
    };
};


_current_artillerys_array = _current_artillerys_array select {_x getVariable [QGVAR(fdc_ready),true]};

If (_current_artillerys_array isEqualTo []) exitwith {
    TRACE("Artillery not ready, pushback the command");
    HASH_GET(GVAR(FDC),"firemissions") pushBack _current_firemission;
    [LINKFUNC(fdc_handle),[],10] call CBA_fnc_waitAndExecute;
};

private _unit = selectRandom _current_artillerys_array;

SETVAR(_unit,GVAR(fdc_ready),false);
TRACE_5("ArtilleryOrder = %1 - [%2,%3,%4]",_unit,_position,_shelltype,_amount);
///// Add fired Eventhandler -> removes status
//_unit addEventHandler ["Fired",{_this params ["_unit"];_unit setVehicleAmmoDef 1;_unit setVariable [ARR_2(QGVAR(fdc_ready),true)];_unit removeEventHandler [ARR_2("Fired",_thisEventHandler)];}];
[_unit,_position,_shelltype,_amount,{(_this select 0) setVariable [QGVAR(fdc_ready),true];_unit setVehicleAmmoDef 1;}] call EFUNC(artillery,fireAtTarget);
//_unit commandArtilleryFire [_position,_shelltype,_amount];
[] spawn FUNC(fdc_handle);
