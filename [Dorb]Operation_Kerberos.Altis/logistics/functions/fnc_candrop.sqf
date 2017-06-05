/*
    Author: Dorbedo
    
    Description:
        Checks if Unit can drop cargo
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        BOOL
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_target",["_isAceAction",true,[true]]];
if (ace_player getVariable [QGVAR(isloading),false]) exitWith { false };

private _logistic_stack = _target getVariable [QGVAR(stack),[]];
If (((_logistic_stack isEqualTo [])||(vehicle ace_player != _target))&&(_isAceAction)) exitWith {TRACE("stack/vehicle/");false};

If ((!((driver _target)==ace_player))&&(_isAceAction)) exitWith {TRACE("driver");false};

private _velocity = velocity _target;

If (/*((vectorMagnitude _velocity)<100)||*/((vectorMagnitude _velocity)>250)) exitWith {TRACE("speed");false};

private _load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point");
private _position = _target modelToWorld _load_point;
TRACEV_2(_load_point,_position);
If ((_position select 2)<100) exitWith {false};
true;
