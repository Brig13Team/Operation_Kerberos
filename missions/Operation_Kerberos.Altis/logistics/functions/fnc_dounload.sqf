/*
    Author: Dorbedo

    Description:
        unloads Object

    Parameter(s):
        0 : OBJECT - Target

    Returns:
        BOOL
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#define LOADTIME 3
_this params["_target",["_isdrop",false,[false]]];

if (ace_player getVariable [QGVAR(isloading),false]) exitWith {};

ace_player setVariable [QGVAR(isloading),true,true];
GVAR(isloading_pos) = getPos ace_player;
private _anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isclosed");
If (!(_anim isEqualTo "")) then {
    If (_target call compile _anim) then {
        _target call (compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_open")));
        private _isopened = compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isopened"));
        waitUntil{uisleep 0.2;_target call _isopened;};
    };
};

TRACEV_1(_isdrop);

private _logistic_stack = _target getVariable [QGVAR(stack),[]];
if !(_logistic_stack isEqualTo []) then {
    private _cargo = _logistic_stack select ((count _logistic_stack) - 1);
    _cargo = _cargo select ((count _cargo) - 1);
    private _cargoObject = _cargo select 0;
    If ((IS_OBJECT(_cargoObject))&&{!isNull _cargoObject}) then {
        [QEGVAR(common,disableCollision),[_target,_cargoObject],[_target,_cargoObject]] call CBA_fnc_targetEvent;
    };
};

If (_isdrop) then {
    [
        LOADTIME,
        [_target],
        {(_this select 0) call FUNC(unload);ace_player setVariable [QGVAR(isloading),false,true];},
        {ace_player setVariable [QGVAR(isloading),false,true];},
        "",
        {true},
        ["isnotinside"]
    ] call ace_common_fnc_progressBar;
}else{
    [
    LOADTIME,
        [_target, getPos _target],
        {(_this select 0) call FUNC(unload);ace_player setVariable [QGVAR(isloading),false,true];},
        {ace_player setVariable [QGVAR(isloading),false,true];},
        "",
        {((getPos((_this select 0) select 0) distance ((_this select 0)select 1))) < 0.5}
    ] call ace_common_fnc_progressBar;
};
