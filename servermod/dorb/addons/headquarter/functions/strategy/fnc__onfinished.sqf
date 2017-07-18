/*
 *  Author: Dorbedo
 *
 *  Description:
 *      a strategy has been finished called via strategy check
 *
 *  Parameter(s):
 *      0 : LOCATION - the strategy
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_strategy"];

private _type = HASH_GET_DEF(_strategy,"strategytype","");

If (_type isEqualTo "groundattack") then {
    private _attackinggroups = [];
    {
        private _groupStrat = _x getVariable [QGVAR(strategy),locationNull];
        If (_groupStrat isEqualTo _strategy) then {
            _attackinggroups pushBack _x;
        };
    } forEach (["combat"] call FUNC(statemachine_getAIGroups));

    {
        [_x] call FUNC(strategy__onFinishSAD);
    } forEach _attackinggroups;
};

If !(isNull _strategy) then {
    HASH_DELETE(_strategy);
};
