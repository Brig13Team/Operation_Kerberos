/*
 *  Author: iJesuz
 *
 *  Description:
 *      Handle Radiotower Damage
 *
 *  Parameter(s):
 *      0 : HASH    - mission
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_radiotower"];
    private _damage = damage _radiotower;

    if ((_damage > 0.9) && {_radiotower getVariable [QGVAR(isActive), true]}) then {
        [_radiotower] call FUNC(obj__increaseCounter);
    }
}
