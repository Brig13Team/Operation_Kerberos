/*
    Author: Dorbedo
    
    Description:
        Checks if Unit can change Cargo-state
        
    Parameter(s):
        0 : OBJECT - Target
        1 : BOOL - extend cargo ?
        
    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params["_target",["_shallExtend",true,[true]]];
if (player getVariable [QGVAR(isloading),false]) exitWith { false };

private _logistic_stack = _target getVariable [QGVAR(stack),[]];

If (_shallExtend) exitWith {
    private _isReduced = _target call compile getText(missionconfigFile >> "logistics" >> "vehicles" >> typeOf _target >> "cargo" >> "isreduced");
    If !(_isReduced isEqualType true) exitWith {false};
    (_isReduced && (_logistic_stack isEqualTo []))
};

private _isExtended = _target call compile getText(missionconfigFile >> "logistics" >> "vehicles" >> typeOf _target >> "cargo" >> "isextended");
If !(_isExtended isEqualType true) exitWith {false};
(_isExtended && (_logistic_stack isEqualTo []) && (fullCrew [_target, "Cargo", false] isEqualTo []))