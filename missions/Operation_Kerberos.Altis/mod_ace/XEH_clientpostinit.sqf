/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

/*
 * Advanced Medical -> Add a chance to revive players
 */

[
    "ace_medical_treatmentAdvanced_CPRLocal",
    {
        params ["_caller", "_target"];

        If (GVAR(revivesettings) < 1) exitWith {};

        If (GVAR(revivesettings) == 1) exitWith {
            If ((_target getVariable ["Ace_medical_inReviveState", false]) && {(random 1) >= 0.80}) then {
                _target setVariable ["Ace_medical_inCardiacArrest", true, true];
                _target setVariable ["Ace_medical_inReviveState", false, true];
            };
        };

        private _reviveChance = [0.10, 0.20, 0.40] select (_target getVariable ["ACE_medical_medicClass", 0]);

        If ((GVAR(lastEpiTime) + 120) >= CBA_missiontime) then {
            _reviveChance = _reviveChance + 0.15;
        };

        private _bloodloss = [_target] call ACE_medical_fnc_getBloodLoss;

        If (_target getVariable ["Ace_medical_inReviveState", false]) then {

            private _reviveStartTime = _target getVariable "ace_medical_reviveStartTime";
            if !(isNil "_reviveStartTime") then {
                _target setVariable ["ace_medical_reviveStartTime", _reviveStartTime + 15 + random 5];
            };

            If ((random 1) < _reviveChance) then {
                // reset the revive state
                _target setVariable ["Ace_medical_inCardiacArrest", true, true];
                _target setVariable ["Ace_medical_inReviveState", false, true];
            };
        };

        If ((_target getVariable ["ace_medical_pain", 0]) < 0.6) then {
            [_target, 0.2] call ace_medical_fnc_adjustPainLevel
        };

        // Damage to target
        If ((random 1) < 0.05) then {
            [_target, 0.2, "body", "punch"] call ace_medical_fnc_addDamageToUnit;
        };

    }
] call CBA_fnc_addEventHandler;

[
    "ace_medical_treatmentAdvanced_fullHealLocal",
    {
        If (GVAR(revivesettings) < 2) exitWith {};

        params ["_caller", "_target"];
        _target setVariable ["ace_medical_amountOfReviveLives", ace_medical_amountOfReviveLives, true];
    }
] call CBA_fnc_addEventHandler;

[
    "ace_medical_treatmentAdvanced_medicationLocal",
    {
        If (GVAR(revivesettings) < 2) exitWith {};

        params ["_target", "_className", "_partNumber"];
        If (_className == "Epinephrine") then {
            GVAR(lastEpiTime) = CBA_missiontime;
        };
    }
] call CBA_fnc_addEventHandler;

/*
 * Change Team Colors -> Ace Copy
 */
[] call FUNC(addColorActions);
