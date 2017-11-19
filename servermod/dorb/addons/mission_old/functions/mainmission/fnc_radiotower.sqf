/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "radiotower"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setVectorUp [0,0,1];

    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["HandleDamage", {
            _this params ["_radiotower","_selection","_newdamage"];
            private _damage = (damage _radiotower) + _newdamage;
            if ((_damage > 0.9) && {_radiotower getVariable [QGVAR(isActive), true]}) then {
                [_radiotower] call FUNC(statemachine_increaseCounter);
            };
            nil;
        }];
} forEach _targets;
