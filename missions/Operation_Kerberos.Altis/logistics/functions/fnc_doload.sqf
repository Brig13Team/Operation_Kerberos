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
If (ace_player getVariable [QGVAR(isloading),false]) exitWith {};
TRACEV_3(_target,_vehicle,_object);
If (!isNull _object) then {
    ace_player setVariable [QGVAR(isloading),true,true];
    GVAR(isloading_pos)=getPos ace_player;
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
    If (_object getVariable ["ACE_dragging_canDrag",false]) then {
        GVAR(aceactions) set [0,true];
        _object setVariable ["ACE_dragging_canDrag",false,true];
    };
    If (_object getVariable ["ACE_dragging_canCarry",false]) then {
        GVAR(aceactions) set [1,true];
        _object setVariable ["ACE_dragging_canCarry",false,true];
    };
    _object setVariable [QGVAR(aceactions),GVAR(aceactions),true];
    [
        LOADTIME,
        [_vehicle,_object, getPos _vehicle, getPos _object],
        {(_this select 0) call FUNC(load);ace_player setVariable [QGVAR(isloading),false,true];},
        {ace_player setVariable [QGVAR(isloading),false,true];},
        "",
        {
            if (( (getPos((_this select 0) select 0)) distance ((_this select 0) select 2)) > 0.5) exitWith {TRACE("Vehicle has been moved"); false };
            if (( (getPos((_this select 0) select 1)) distance ((_this select 0) select 3)) > 0.5) exitWith {TRACE("Object has been moved"); false };
            true;
        }
    ] call ace_common_fnc_progressBar;
};
