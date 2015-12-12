/*
    Author: Dorbedo
    
    Description:
        registers a group for the HQ
    
    Parameter(s):
        0:GROUP/OBJECT - the group to be registered
        

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(register_Group);
_this params[["_group",grpnull,[grpnull,objNull]]];
TRACEV_1(_group);
If (isNull _group) exitWith {false};
_group = [_group] call CBA_fnc_getGroup;
If (GETVAR(_group,GVAR(registered),false)) exitWith {false};

([_group] call FUNC(strength)) params ["_type","_strenght"];

If (_type isEqualTo "") exitWith {false};

private _temp = missionNameSpace getVariable [QGVAR("")+_type,[]];

_temp append [[_group,_strenght]];

missionNameSpace setVariable [QGVAR("")+_type,_temp];

SETVAR(GVAR(registered),true);

true