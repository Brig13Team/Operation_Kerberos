/*
    Author: Dorbedo
    
    [cursortarget] execVM "functions\scripte\fnc_logHelper.sqf";
*/

params[["_vehicle",objNull,[objNull]]];

if(isNull _vehicle) exitWith {hint "Kein Fahrzeug übergeben"};

DORB_HELPER_VEH=_vehicle;
DORB_HELPER_POS=[0,0,0];

If (!(isNil "DORB_HELPER_ARROW")) then {
    {deleteVehicle _x} forEach DORB_HELPER_ARROW;
};

If (!(isNil "DORB_HELPER_ID")) then {
    [DORB_HELPER_ID] call CBA_fnc_removePerFrameHandler;
};


DORB_HELPER_ARROW = [createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CANCOLLIDE"] ];

DORB_HELPER_ID = [{
    private["_pos"];
    If (isNull DORB_HELPER_VEH) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;deleteVehicle DORB_HELPER_ARROW;};
    _pos = DORB_HELPER_VEH modelToWorld DORB_HELPER_POS;
    (DORB_HELPER_ARROW select 0) setPos _pos;
}, 0, []] call CBA_fnc_addPerFrameHandler;