/*
    Author: Dorbedo

    Description:
    Spawns Attackforce

    Parameter(s):
        0 :    ARRAY    - Position
        (optional)
        1 : NUMBER     - Radius
        2 : NUMBER     - Amount of strikeforce-Groups
        

    Returns:
        Nothing

*/
#include "script_component.hpp"
SCRIPT(strikeforce_create);
params["_centerposition",["_amount",0,[0]],["_radius",600,[0]]];

for "_i" from 0 to _amount do {
    private _rad = ((random 600) + 200);
    private _pos = [_position,_radius,0] call EFUNC(common,pos_random);
    private _spawnpos = _pos findEmptyPosition [1,40];
    private _grouptype = selectRandom GVAR(group_strikeforce);

    if (_spawnpos isEqualTo []) then {
        ERROR("Keine Spawnposition");
    }else{
        private _group = [_spawnpos, _grouptype] call FUNC(group);
        SETPVAR(_group,EGVAR(headquarter,state),'wait');
        SETPVAR(_group,EGVAR(headquarter,target),_spawnpos);
        [_group] call EFUNC(headquarter,state_change);
    };
};

