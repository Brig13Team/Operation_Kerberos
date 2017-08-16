/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preloads the ArsenalList
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(canSuspend) exitWIth {
    _this spawn FUNC(preload);
};

If (GVAR(level)<1) exitWith {
    GVAR(isPreloaded) = true;
};

If (GVAR(level)<2) exitWith {
    If (isNull(missionNamespace getVariable [QGVAR(level_1_obj),objNull])) then {
        GVAR(level_1_obj) = [] call FUNC(createLocalArsenal);
        [GVAR(level_1_obj)] call FUNC(addRestrictedArsenal);
    };
    GVAR(isPreloaded) = true;
};

private _arsenalVarName = format[QGVAR(level_2_obj_%1),side ace_player];

If (isNull(missionNamespace getVariable [_arsenalVarName,objNull])) then {
    missionNamespace setVariable [_arsenalVarName,([] call FUNC(createLocalArsenal))];
    [(missionNamespace getVariable _arsenalVarName),side ace_player,true] call FUNC(addSideRestrictedArsenal);
    GVAR(isPreloaded) = true;
};
