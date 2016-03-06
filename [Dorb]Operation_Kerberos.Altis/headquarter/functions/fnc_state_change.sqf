/*
    Author: Dorbedo
    
    Description:
        changes the state
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(state_change);
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;
private _strength = [_group] call FUNC(strength);
_group setVariable [QGVAR(strength),_strength];

_state = toLower (GETVAR(_group,GVAR(state),''));

switch (_state) do {
    case "patrol" : {
            private _formation = selectRandom ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"];
            private _position = GETVAR(_group,GVAR(target),getPos (leader _group));
            [_group, _position, "AWARE", "WHITE", "NORMAL", "NO CHANGE", "", [5,10,15],50] call EFUNC(spawn,patrol_task);
        };
    default {[_group] call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_state),_state],{}]);};
};
