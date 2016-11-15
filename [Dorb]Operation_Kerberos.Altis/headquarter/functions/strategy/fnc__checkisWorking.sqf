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
If (isNil "_strategy") exitWith {false};
//// Check for Timeout

private _timeout = HASH_GET(_strategy,"timeout");
If ((_timeout > 0)&&{_timeout < CBA_missiontime}) exitWith {
    HASH_DELETE(_strategy);
    false;
};

private _finishCondition = HASH_GET_DEF(_strategy,"finishcondition",{true});
private _parameter = HASH_GET_DEF(_strategy,"parameter",[]);

If (!(_parameter call _finishCondition)) exitWith {false};

/// TODO evaluate if the strategy finished with success

private _onFinish = HASH_GET_DEF(_strategy,"onfinish",{true});
_parameter spawn _onFinish;

true;
