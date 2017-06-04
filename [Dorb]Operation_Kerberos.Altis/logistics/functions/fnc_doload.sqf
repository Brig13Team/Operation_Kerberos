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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_target","_caller","_params"];
_params params [["_object",objNull,[objNull]],"_vehicle"];
CHECK(player getVariable [QGVAR(isloading),false];)
TRACEV_3(_target,_vehicle,_object);
If (!isNull _object) then {
    player setVariable [QGVAR(isloading),true];
    GVAR(isloading_pos)=getPos player;
    private _anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "hatch_isclosed");
    TRACEV_2(_anim,(typeOf _vehicle));
    If (!(_anim isEqualTo "")) then {
        TRACEV_1((_vehicle call compile _anim));
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
        [_vehicle,_object, getPos _vehicle, getPos _object],
        {(_this select 0) call FUNC(load);player setVariable [QGVAR(isloading),false];},
        {player setVariable [QGVAR(isloading),false];},
        "",
        {
            if (( (getPos((_this select 0) select 0)) distance ((_this select 0) select 2)) > 0.5) exitWith {TRACE("Vehicle has been moved"); false };
            if (( (getPos((_this select 0) select 1)) distance ((_this select 0) select 3)) > 0.5) exitWith {TRACE("Object has been moved"); false };
            true;
        }
    ] call ace_common_fnc_progressBar;
};
