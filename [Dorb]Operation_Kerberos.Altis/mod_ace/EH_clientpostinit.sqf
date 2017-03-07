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
["ace_medical_treatmentAdvanced_CPRLocal",{
    _this params ["_caller","_target"]; If ((_target getVariable ["Ace_medical_inReviveState",false])&&{(random 1) >= 0.80}) then {
        _target setVariable ["Ace_medical_inCardiacArrest",true,true];
        _target setVariable ["Ace_medical_inReviveState",false,true];
    };
}] call CBA_fnc_addEventHandler;
/*
 * Change Team Colors -> Ace Copy
 *
*/
[] call FUNC(addColorActions);
