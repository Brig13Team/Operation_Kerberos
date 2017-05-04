/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks a strategie
 *
 *  Parameter(s):
 *      0 : LOCATION - Strategie to check
 *
 *  Returns:
 *      BOOL - Is active
 *
 */
#include "script_component.hpp"

_this params ["_strategy"];
If ((isNil "_strategy")||{isNull _strategy}) exitWith {false};
//// Check for Timeout

private _timeout = HASH_GET_DEF(_strategy,"timeout",-1);
If ((_timeout > 0)&&{_timeout < CBA_missiontime}) exitWith {
    [_strategy] call FUNC(strategy__onfinished);
    false;
};

private _finishCondition = HASH_GET_DEF(_strategy,"finishcondition",{true});
If (IS_STRING(_finishCondition)) then {
    If (_finishCondition isEqualTo "") then {
        _finishCondition = {true};
    }else{
        _finishCondition = compile _finishCondition;
    };
};
private _parameter = HASH_GET_DEF(_strategy,"parameter",[]);
TRACEV_3((_timeout-CBA_missiontime),_finishCondition,_parameter);
If (!(_parameter call _finishCondition)) exitWith {true};

/// TODO evaluate if the strategy finished with success

private _onFinish = HASH_GET_DEF(_strategy,"onfinish","");
If !(_onFinish isEqualTo "") then {
    _parameter spawn (missionNamespace getvariable [_onFinish,{true}]);
};

[_strategy] call FUNC(strategy__onfinished);

false;
