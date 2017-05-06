/*
    Author: Dorbedo

    Description:
        adds KnockKnockSound

    Parameter(s):
        none

    Return
        none
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(!hasInterface)

private _Action = [
    QGVAR(action_knockknock),
    localize LSTRING(ACTION_KNOCKKNOCK),
    "",
    {[QGVAR(KnockKnock),[_target,player]] call CBA_fnc_globalEvent;},
    {alive _target}
] call ace_interact_menu_fnc_createAction;


private _targets = ["Tank"];
{
    private _vehicle = configname(_x);
    If (({_vehicle isKindOf _x} count _targets)>0) then {
        [_vehicle, 0, ["ACE_MainActions"], _Action] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach (configProperties [(configFile >> "CfgVehicles"), "(isClass _x)&&{((configName _x) isKindOf 'Tank')&&{getNumber(_x >> 'scope') > 1}}"]);

[
    QGVAR(KnockKnock),
    {
        _this params ["_tank","_knocker"];
        [_tank,_knocker] say3D QGVARMAIN(sound_knockknock);
    }
] call CBA_fnc_addEventHandler;
