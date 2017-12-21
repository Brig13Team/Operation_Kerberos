/*
    Author: Dorbedo

    Description:
        Opens the arsenal

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
If !(canSuspend) exitWIth {
    _this spawn FUNC(OpenMenu);
};

params [["_fastArsenal",false,[true]]];

TRACEV_2(_fastArsenal,_this);
[] call EFUNC(gui_main,close);

If (GVAR(level)<1) exitWith {
    If (isNull (missionNamespace getVariable [QGVAR(obj_level_0), objNull])) then {
        [QGVAR(obj_level_0)] call FUNC(preLoad);
    };
    [
        GVAR(obj_level_0),
        ace_player,
        true
    ] call ace_arsenal_fnc_openBox;
};

If (GVAR(level)<2) exitWith {
    If ((isNull (missionNamespace getVariable [QGVAR(obj_level_1), objNull])) || {GVAR(forceReload)}) then {
        [QGVAR(obj_level_1)] call FUNC(preLoad);
    };
    [
        GVAR(obj_level_1),
        ace_player,
        false
    ] call ace_arsenal_fnc_openBox;
};

If (GVAR(level)<3) then {
    If ((isNull (missionNamespace getVariable [format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player], objNull])) || {GVAR(forceReload)}) then {
        [
            format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player]
        ] call FUNC(preLoad);
    };
    [
        missionNamespace getVariable (format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player]),
        ace_player,
        false
    ] call ace_arsenal_fnc_openBox;
} else {
    If ((isNull (missionNamespace getVariable [format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player], objNull])) || {GVAR(forceReload)}) then {
        [
            format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player]
        ] call FUNC(preLoad);
    };
    [
        missionNamespace getVariable (format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player]),
        ace_player,
        false
    ] call ace_arsenal_fnc_openBox;
};
