/*
    Author: Dorbedo
    
    Description:
        loads an object
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        BOOL
*/
#include "script_component.hpp"
SCRIPT(doload);
#define LOADTIME 3
PARAMS_1(_target);

CHECK(GETVAR(player,GVAR(isloading),false))
private["_nearObjects","_object"];
_nearObjects = nearestObjects[(_target modelToWorld (getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point"))), ["AllVehicles","ThingX"], 2];
_object = objNull;

{
    If (!(([_x] call FUNC(getCargoCfg))isEqualTo "")) exitWith {
        _object = _x;
    };
}forEach _nearObjects;

If (!isNull _object) then {
    SETVAR(player,GVAR(isloading),true);
    GVAR(isloading_pos)=getPos player;
    private["_anim"];
    _anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isclosed");
    If (!(_anim isEqualTo "")) then {
        If (_target call compile _anim) then {
            _target call (compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_open")));
            private "_isopened";
            _isopened = compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isopened"));
            waitUntil{uisleep 0.2;_target call _isopened;};
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
        {(((getPos player) distance GVAR(isloading_pos))<1)},
        {_this call FUNC(load);SETVAR(player,GVAR(isloading),false);},
        {SETVAR(player,GVAR(isloading),false);},
        [_object,_target]
    ] call EFUNC(interface,disp_progressbar);
};
