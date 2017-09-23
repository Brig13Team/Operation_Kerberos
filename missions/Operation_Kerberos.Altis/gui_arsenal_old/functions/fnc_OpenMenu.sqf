/*
    Author: Dorbedo

    Description:
        Opens the arsenal

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(canSuspend) exitWIth {
    _this spawn FUNC(OpenMenu);
};

_this params [["_fastArsenal",false,[true]]];
TRACEV_2(_fastArsenal,_this);
[] call EFUNC(gui_echidna,close);

If (GVAR(level)<1) exitWith {
    GVAR(isPreloaded) = true;
    If (_fastArsenal) then {
        [] call FUNC(OpenfastArsenalList);
    }else{
        ["Open",true] spawn BIS_fnc_arsenal;
    };
};

If (GVAR(level)<2) exitWith {
    If (isNull(missionNamespace getVariable [QGVAR(level_1_obj),objNull])) then {
        GVAR(level_1_obj) = [] call FUNC(createLocalArsenal);
        [GVAR(level_1_obj)] call FUNC(addRestrictedArsenal);
    };
    If (GVAR(forceReload)) then {[GVAR(level_1_obj)] call FUNC(addRestrictedArsenal);};
    If (GVAR(debugArsenal)) then {[GVAR(level_1_obj)] call FUNC(debugTemplate);};
    GVAR(isPreloaded) = true;
    If (_fastArsenal) then {
        [] call FUNC(Open);
    }else{
        ["Open",[nil,GVAR(level_1_obj),ace_player]] call bis_fnc_arsenal;
    };
};

private _arsenalVarName = format[QGVAR(level_2_obj_%1),side ace_player];

If (isNull(missionNamespace getVariable [_arsenalVarName,objNull])) then {
    missionNamespace setVariable [_arsenalVarName,([] call FUNC(createLocalArsenal))];
    TRACEV_2((missionNamespace getVariable _arsenalVarName),side ace_player);
    [(missionNamespace getVariable _arsenalVarName),side ace_player,true] call FUNC(addSideRestrictedArsenal);
};
If (GVAR(forceReload)) then {[(missionNamespace getVariable _arsenalVarName),side ace_player,true] call FUNC(addSideRestrictedArsenal);};
If (GVAR(debugArsenal)) then {[(missionNamespace getVariable _arsenalVarName)] call FUNC(debugTemplate);};
GVAR(isPreloaded) = true;
If (_fastArsenal) then {
    [] call FUNC(Open);
}else{
    ["Open",[nil,(missionNamespace getVariable _arsenalVarName),ace_player]] call bis_fnc_arsenal;
};
