/*
    Author: Dorbedo

    Description:
        INTERNAL
        spawns an event

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place of the Eventhandler

*/
#include "script_component.hpp"
_this params [
    ["_eventName","",[""]],
    ["_parameter",[],[[]]],
    ["_namespace",missionnamespace,[missionnamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationnull]]
    ];
private _events = _namespace getVariable QGVAR(events);
private _eventIndex = _eventNames find _eventName;
CHECK(_eventIndex < 0);
{
    _parameter call _x;
} forEach ((_events select 1) select _eventIndex);