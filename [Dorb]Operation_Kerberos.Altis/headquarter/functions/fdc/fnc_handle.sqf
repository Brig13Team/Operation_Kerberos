/*
    Author: Dorbedo

    Description:
        The FDC - Logic
        coordinates artilleryfire, sends firemissions, tries to defend artillery sites

    Parameter(s):
        0 : ARRAY   - params
        1 : SCALAR  - Handle

*/
#include "script_component.hpp"

If (HASH_GET(GVAR(FDC),"firemissions") isEqualTo []) exitWith {};
private _current_firemission = HASH_GET(GVAR(FDC),"firemissions") deleteAt 0;
_current_firemission params ["_position","_type","_shelltype","_amount"];

HASH_SET(GVAR(FDC),"artilleries",(HASH_GET(GVAR(FDC),"artilleries") select {alive _x}));
HASH_SET(GVAR(FDC),"mortars",(HASH_GET(GVAR(FDC),"mortars") select {alive _x}));
HASH_SET(GVAR(FDC),"rockets",(HASH_GET(GVAR(FDC),"rockets") select {alive _x}));

private _current_artillerys_array = switch(_type) do {
    case 0 : {HASH_GET(GVAR(FDC),"artilleries") call BIS_fnc_arrayShuffle};
    case 1 : {HASH_GET(GVAR(FDC),"mortars") call BIS_fnc_arrayShuffle};
    case 2 : {HASH_GET(GVAR(FDC),"rockets") call BIS_fnc_arrayShuffle};
    default {[]};
};

If (_current_artillerys_array isEqualTo []) exitwith {TRACE_1("No artilleryunit found for Mission: \n %1",_current_firemission);};
private _unit = {
    If ((_position inRangeOfArtillery [[_x],_shelltype])&&(_shelltype in getArtilleryAmmo[_x])&&(GETVAR(_x,GVAR(fdc_ready),true))) exitwith {_x};
}forEach _current_artillerys_array;

If((isNil "_unit")||{(!(IS_OBJECT(_unit)))}) exitwith {
    HASH_GET(GVAR(FDC),"firemissions") pushBack _current_firemission;
};

SETVAR(_unit,GVAR(fdc_ready),false);
TRACE_5("ArtilleryOrder = %1 - [%2,%3,%4]",_unit,_position,_shelltype,_amount);
///// Add fired Eventhandler -> removes status
_unit addEventHandler ["Fired",{(_this select 0) setVariable [ARR_2(QGVAR(fdc_ready),true)];(_this select 0) removeAllEventHandlers "Fired";}];
_unit commandArtilleryFire [_position,_shelltype,_amount];
