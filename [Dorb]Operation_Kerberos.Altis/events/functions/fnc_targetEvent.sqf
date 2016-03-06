/*
    Author: Dorbedo

    Description:
        raises a targetEvent

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place of the Eventhandler
        3 : OBJECT - target

*/
#include "script_component.hpp"
If (_this params [
    ["_eventname","",[""]],
    ["_params",[],[[]]],
    ["_namespace",missionNamespace,[missionNamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationNull]]
    ["_target",[],[[],objNull,1,west,grpNull,true]]
    ])then {

    [
        _this,
        QUOTE(FUNC(__raiseEvent)),
        _target,
        false,
        false
    ] call FUNC(remoteExec);
};