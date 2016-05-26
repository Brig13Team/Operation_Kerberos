/*
    Author: Dorbedo
    
    Description:
        Checks if Unit can drop cargo
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params["_target",["_isAceAction",true,[true]]];
if (player getVariable [QGVAR(isloading),false]) exitWith { false };

private _logistic_stack = _target getVariable [QGVAR(stack),[]];
If (((_logistic_stack isEqualTo [])||(vehicle player != _target))&&(_isAceAction)) exitWith {false};

If ((!((driver _target)==player))&&(_isAceAction)) exitWith {false};

private _velocity = velocity _target;

If (/*((vectorMagnitude _velocity)<100)||*/((vectorMagnitude _velocity)>250)) exitWith {false};

private _load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point");
private _position = _target modelToWorld _load_point;

If ((_position select 2)<100) exitWith {false};
true;