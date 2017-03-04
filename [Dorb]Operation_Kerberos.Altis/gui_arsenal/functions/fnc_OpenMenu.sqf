/*
    Author: Dorbedo

    Description:
        Opens the arsenal

*/
#include "script_component.hpp"

If !(canSuspend) exitWIth {
    _this spawn FUNC(OpenMenu);
};


If (GVAR(level)<1) exitWith {
    ["Open",true] spawn BIS_fnc_arsenal;
};

[QEGVAR(patch_acre,removeRadio)] call CBA_fnc_localEvent;

If (GVAR(level)<2) exitWith {
    If (isNull(missionNamespace getVariable [QGVAR(level_1_obj),objNull])) exitWith {
        GVAR(level_1_obj) = [] call FUNC(createLocalArsenal);
        [GVAR(level_1_obj)] call FUNC(addRestrictedArsenal);
    };
    ["Open",[nil,GVAR(level_1_obj),ace_player]] call bis_fnc_arsenal;
};

private _arsenalVarName = format[QGVAR(level_2_obj_%1),side ace_player];

If (isNull(missionNamespace getVariable [_arsenalVarName,objNull])) exitWith {
    missionNamespace setVariable [_arsenalVarName,([] call FUNC(createLocalArsenal))];
    [(missionNamespace getVariable [_arsenalVarName,objNull]),side ace_player,true] call FUNC(addSideRestrictedArsenal);
};
["Open",[nil,(missionNamespace getVariable _arsenalVarName),ace_player]] call bis_fnc_arsenal;
