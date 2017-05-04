/*
    Author: Dorbedo

    Description:
        Opens the arsenal

*/
#include "script_component.hpp"

If !(canSuspend) exitWIth {
    _this spawn FUNC(OpenMenu);
};

[] call EFUNC(gui_echidna,close);

If (GVAR(level)<1) exitWith {
    ["Open",true] spawn BIS_fnc_arsenal;
};

If (GVAR(level)<2) exitWith {
    If (isNull(missionNamespace getVariable [QGVAR(level_1_obj),objNull])) then {
        GVAR(level_1_obj) = [] call FUNC(createLocalArsenal);
        [GVAR(level_1_obj)] call FUNC(addRestrictedArsenal);
    };
    If (GVAR(debugArsenal)) then {[GVAR(level_1_obj)] call FUNC(debugTemplate);};
    ["Open",[nil,GVAR(level_1_obj),ace_player]] call bis_fnc_arsenal;
};

private _arsenalVarName = format[QGVAR(level_2_obj_%1),side ace_player];

If (isNull(missionNamespace getVariable [_arsenalVarName,objNull])) then {
    missionNamespace setVariable [_arsenalVarName,([] call FUNC(createLocalArsenal))];
    TRACEV_2((missionNamespace getVariable _arsenalVarName),side ace_player);
    [(missionNamespace getVariable _arsenalVarName),side ace_player,true] call FUNC(addSideRestrictedArsenal);
};
If (GVAR(debugArsenal)) then {[(missionNamespace getVariable _arsenalVarName)] call FUNC(debugTemplate);};
["Open",[nil,(missionNamespace getVariable _arsenalVarName),ace_player]] call bis_fnc_arsenal;
