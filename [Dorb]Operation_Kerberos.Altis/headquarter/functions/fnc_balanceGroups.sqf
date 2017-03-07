/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Moves Patrols to attack, if there are not enaugh attackgroups
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

private _attackgroups = HASH_GET(GVAR(groups),"attackGroups");
private _patrolgroups = HASH_GET(GVAR(groups),"patrolGroups");

If (((count _attackgroups) < 5)&&((count _patrolgroups)>0)) then {
    LOG("Changing patrolgroups into attackgroups");
    private _groupToMove = selectRandom _patrolgroups;
    _patrolgroups = _patrolgroups - [_groupToMove];
    HASH_SET(GVAR(groups),"patrolGroups",_patrolgroups);
    private _group = HASH_GET_DEF(_groupToMove,"group",grpNull);
    If (!isNull _group) then {
        [_group,"attack"] call FUNC(registerGroup);
        private _target = [HASH_GET(GVAR(dangerzones),"centerpos"),400,0] call EFUNC(common,pos_random);
        [_group,"wait",_target] call FUNC(state_set);
    };
};
