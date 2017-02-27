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
    TRACEV_2(_radiotower, _damage);

    if ((_damage > 0.75) && {_radiotower getVariable [QGVAR(isActive), true]}) then {
        _radiotower setVariable [QGVAR(isActive), false];

        private _mission = _radiotower getVariable QGVAR(mission);
        HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
    }
}
