/*
    Author: Dorbedo
    v1.0
*/
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

If (isServer) then {
    ["rhs_zsutank_base", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
    ["B_APC_Tracked_01_AA_F", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
    ["B_SAM_System_01_F", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
    ["B_SAM_System_02_F", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
    ["B_AAA_System_01_F", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
};

["CAManBase", "Killed", {
    /*
    If (!(local (_this select 0))) exitWith {
        //TRACE("Unit not local");
        //TRACEV_1(_this);
    };
    */
    _this spawn FUNC(onKilled);
},true,[],true] call CBA_fnc_addClassEventHandler;

[QGVAR(reveal),{(_this select 0) reveal (_this select 1)}] call CBA_fnc_addEventHandler;
