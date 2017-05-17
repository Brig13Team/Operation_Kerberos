/**
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a new group to the HQ
 *
 *  Parameter(s):
 *      0 : GROUP - the group to register
 *      1 : STRING - the type of group (attack,defence,patrol)
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]],["_type","combat",[""]]];
TRACEV_2(_group,_type);
CHECK(isNull _group)
IF (!(_type in ["attack","defence","patrol","static","combat"])) exitWith {
    ERROR("Wrong state");
};

if (_type == "attack") then {_type = "combat";};

_group = _group call CBA_fnc_getGroup;

_group setVariable [QGVAR(state),_type];

private _strengthArray = ([_group] call FUNC(getstrengthAIGroup)) params ["_value","_strength","_defence","_grouptype"];
_group setVariable [QGVAR(value),_value];
_group setVariable [QGVAR(strength),_strength];
_group setVariable [QGVAR(defence),_defence];
_group setVariable [QGVAR(type),_grouptype];
