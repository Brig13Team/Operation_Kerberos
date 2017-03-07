/*
    Author: Dorbedo

    Description:
        performes the Halo

    Parameter(s):
        (optional)
            Altitude of the startpoint
            Altitude where the cute is opening automatically
    Return
        none
*/
#include "script_component.hpp"
_this params["_host","_caller","_id","_params"];
_params params[["_althalo",500,[0]],["_altchute",100,[0]]];

if ((count ([]call EFUNC(common,players)))>7) exitWith {[QGVAR(message),[LSTRING(HALO),LSTRING(HALO_DISABLED)]] call CBA_fnc_localEvent;};

if !(alive _host) exitwith {
    [QGVAR(message),[LSTRING(HALO),LSTRING(HALO_DISABLED)]] call CBA_fnc_localEvent;
    _host removeaction _id;
};

if (vehicle _caller == _caller) then {
    [QGVAR(message),[LSTRING(HALO),LSTRING(HALO_KLICK)]] call CBA_fnc_localEvent;
    openMap true;
    GVAR(halo_clicked) = false;
    private _handler = [QGVAR(halo_handler),"onMapSingleClick",{GVAR(halo_pos)= _pos;GVAR(halo_clicked) = true;true;}] call BIS_fnc_addStackedEventHandler;
    waituntil {GVAR(halo_clicked) or !(visiblemap)};
    [QGVAR(halo_handler),"onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
    if !(GVAR(halo_clicked)) exitwith {
        [LSTRING(HALO),LSTRING(HALO_ABORT)] call EFUNC(gui,message);
    };
    _caller setpos [GVAR(halo_pos) select 0, GVAR(halo_pos) select 1, _althalo];
    _caller spawn bis_fnc_halo;
};

if (getpos _caller select 2 > (_altchute + 100)) then {
    uisleep 1;
    [_caller] spawn bis_fnc_halo;
    private _bis_fnc_halo_action = _caller addaction [format["<t size='1.5' shadow='2' color='#ff0000'>%1</t> <img size='3' color='#ff0000' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>",localize LSTRING(HALO_OPEN)],"A3\functions_f\misc\fn_HALO.sqf",[],1,false,true,"Eject"];
    uisleep 5;
    //auto open before impact
    waituntil {(position _caller select 2) <= _altchute};
    _caller removeaction _bis_fnc_halo_action;
    if !((vehicle _caller) iskindof "ParachuteBase") then {
        [_caller] spawn bis_fnc_halo;
    };
    waituntil {(position _caller select 2) < 1};
    _caller action ["Eject", vehicle _caller];
    _caller switchmove "adthppnemstpsraswrfldnon_1";
    _caller setvelocity [0,0,0];
};
