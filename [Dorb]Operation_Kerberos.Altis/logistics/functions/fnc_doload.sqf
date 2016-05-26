/*
    Author: Dorbedo
    
    Description:
        loads an object
        
    Parameter(s):
        0 : OBJECT - Target
        1 : OBJECT - Cargo
        
    Returns:
        BOOL
*/
#include "script_component.hpp"
_this params ["_target","_caller","_params"];
_params params ["_vehicle",["_object",objNull,[objNull]]];
CHECK(GETVAR(player,GVAR(isloading),false))

If (!isNull _object) then {
    SETVAR(player,GVAR(isloading),true);
    GVAR(isloading_pos)=getPos player;
    private _anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "hatch_isclosed");
    If (!(_anim isEqualTo "")) then {
        If (_vehicle call compile _anim) then {
            _vehicle call (compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "hatch_open")));
            private _isopened = compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "hatch_isopened"));
            waitUntil{uisleep 0.2;_vehicle call _isopened;};
        };
    };
    GVAR(aceactions) = [false,false];
    If (GETVAR(_object,ACE_dragging_canDrag,false)) then {
        GVAR(aceactions) set [0,true];
        SETPVAR(_object,ACE_dragging_canDrag,false);
    };
    If (GETVAR(_object,ACE_dragging_canCarry,false)) then {
        GVAR(aceactions) set [1,true];
        SETPVAR(_object,ACE_dragging_canCarry,false);
    };
    SETPVAR(_object,GVAR(aceactions),GVAR(aceactions));
    [
        LOADTIME,
        [_object,_vehicle, getPos _object, getPos _vehicle],
        {(_this select 0) call FUNC(load);SETVAR(player,GVAR(isloading),false);},
        {SETVAR(player,GVAR(isloading),false);},
        "",
        { if (!((getPos (_this select 0 select 0)) isEqualTo (_this select 0 select 2))) exitWith { false }; if (!((getPos (_this select 0 select 1)) isEqualTo (_this select 0 select 3))) exitWith { false }; true }
    ] call ace_common_fnc_progressBar;
};