/*
    Author: Dorbedo

    Description:
        removes all Eventhandlers

    Parameter(s):
    (optional)
        0 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
        1 : STRING - Name of the Eventhandler - if not set, all Eventhandler will be removed

*/
#include "script_component.hpp"
_this params [
    ["_namespace",missionnamespace,[missionnamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationnull]],
    ["_eventName","",[""]]
    ];
If (_eventName isEqualTo "") exitWith {
    _namespace setVariable [QGVAR(events),nil];
    true;
};
private _events = _namespace getVariable QGVAR(events);
CHECKRET((isNil "_events"),true);

private _eventNames = _events select 0;
private _eventIndex = _eventNames find _eventName;
CHECKRET((_eventIndex < 0),true);
private _eventFunctions = _events select 1;
_eventNames deleteAt _eventIndex;
_eventFunctions deleteAt _eventIndex;
_namespace setVariable [QGVAR(events),[_eventNames,_eventFunctions]];
true;