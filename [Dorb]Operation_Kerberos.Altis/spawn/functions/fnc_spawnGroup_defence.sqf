/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns defencegroups
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : SCALAR - Radius
 *      2 : SCALAR - amount of groups
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params["_centerposition",["_amount",0,[0]],["_radius",50,[0]]];

for "_i" from 0 to _amount do {
    [] call FUNC(delaySpawn);
    private _spawnpos = [_centerposition,_radius,0] call EFUNC(common,pos_random);
    private _spawnpos = _spawnpos findEmptyPosition [1,40];
    private _grouptype = ["defence"] call FUNC(getGroup);

    if (_spawnpos isEqualTo []) then {
        ERROR("no spawnposition");
    }else{
        private _group = [_spawnpos, _grouptype] call FUNC(group);
        [_group,"defence"] call EFUNC(headquarter,registerGroup);
        [_group,"defence"] call EFUNC(headquarter,state_set);
    };
};
