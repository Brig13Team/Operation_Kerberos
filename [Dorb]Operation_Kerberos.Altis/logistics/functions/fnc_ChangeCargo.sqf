/*
    Author: Dorbedo
    
    Description:
        changes Cargo-state
        
    Parameter(s):
        0 : OBJECT - Target
        1 : BOOL - extend cargo ?
        
    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params["_vehicle",["_shallExtend",true,[true]]];
if (player getVariable [QGVAR(isloading),false]) exitWith { false };

If (_shallExtend) exitWith {
    _vehicle call compile getText(missionconfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle >> "cargo" >> "extend");
};
_vehicle call compile getText(missionconfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle >> "cargo" >> "reduce");