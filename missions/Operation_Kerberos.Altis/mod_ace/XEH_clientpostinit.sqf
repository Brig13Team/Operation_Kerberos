/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

/*
 * Advanced Medical -> Add a chance to revive players
 *
*/
#define CPR_PAIN 0.6
[
    "ace_medical_treatmentAdvanced_CPRLocal",
    {
        params ["_caller", "_target"];

        private _reviveChance = [0.10, 0.20, 0.40] select (_target getVariable ["ACE_medical_medicClass", 0]);

        private _bloodloss = [_target] call ACE_medical_fnc_getBloodLoss;

        If (_target getVariable ["Ace_medical_inReviveState", false]) then {
            If ((random 1) < _reviveChance) then {
                // reset the revive state
                _target setVariable ["Ace_medical_inCardiacArrest", true, true];
                _target setVariable ["Ace_medical_inReviveState", false, true];
            };
            If ((_target getVariable ["ace_medical_pain", 0]) < CPR_PAIN) then {
                [_target, 0.5] call ace_medical_fnc_adjustPainLevel
            };
        } else {
            If ((_target getVariable ["ace_medical_pain", 0]) < CPR_PAIN) then {
                [_target, 0.5] call ace_medical_fnc_adjustPainLevel
            };
        };
    }
] call CBA_fnc_addEventHandler;

/*
 * Change Team Colors -> Ace Copy
 */
[] call FUNC(addColorActions);
