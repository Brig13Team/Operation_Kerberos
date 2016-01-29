/*
    Author: Dorbedo

    Description:
        removes an Eventhandler

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ID - the ID of the Eventhandler
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
    Returns:
        SCALAR - ID of the Eventhandler

*/
#include "script_component.hpp"
_this params [
    ["_eventName","",[""]],
    ["_ID",-1,[0]],
    ["_namespace",missionnamespace,[missionnamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationnull]]
    ];
CHECKRET(((_eventName isEqualTo "")||(_ID < 0)),false);

private _events = _namespace getVariable QGVAR(events);
CHECKRET((isNil "_events"),true);

private _eventNames = _events select 0;
private _eventIndex = _eventNames find _eventName;
CHECKRET((_eventIndex < 0),true);

_eventFunctionsArray = (_events select 1) select _eventIndex;
CHECKRET(((count _eventFunctionsArray)<(_ID+1)),true);
_eventFunctionsArray set [_ID,nil];
(_events select 1) set [_eventIndex,_eventFunctionsArray];
_namespace setVariable [QGVAR(events),_events];
true;
