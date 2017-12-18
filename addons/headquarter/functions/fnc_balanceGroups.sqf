/**
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

private _attackgroups = ["combat"] call FUNC(statemachine_getAIGroups);
private _patrolgroups = ["patrol"] call FUNC(statemachine_getAIGroups);


If (((count _attackgroups) < 4)&&((count _patrolgroups)>0)) then {
    TRACE("Changing patrolgroups into attackgroups");
    private _groupToMove = selectRandom _patrolgroups;
    _groupToMove setVariable [QGVAR(state),"combat"];
};
