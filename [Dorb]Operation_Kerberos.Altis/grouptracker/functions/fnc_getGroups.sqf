/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the groups for the grouptracker
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - array with all visible groups
 *
 */
#include "script_component.hpp"

private _groups = [];

If ((!(isNull (getAssignedCuratorLogic player)))||(GVAR(showAll))) then {
    _groups = allGroups select {(({alive _x}count (units _x)) >0)};
}else{
    If (GVAR(AiIsVisible)) then {
        {
            If ((side(leader _x ) == playerSide) and (({alive _x}count (units _x)) >0)) then {
                _groups pushBack _x;
            };
        } forEach (allGroups - (missionNamespace getVariable [QGVAR(hiddenGroups),[]]));
    }else{
        {
            If ((isPlayer (leader _x)) and (side(leader _x) == playerSide)and((count (units _x)) >0)) then {
                _groups pushBack _x;
            };
        } forEach (allGroups - (missionNamespace getVariable [QGVAR(hiddenGroups),[]]));
    };
};
_groups;
