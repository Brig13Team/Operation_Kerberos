/*
    Author: Dorbedo

    Description:
        raises an Event

    Parameter(s):
        0 : STRING - Name of the Eventhandler
		1 : ARRAY - Parameter for the Event
	(optional)
		2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
	Returns:
		SCALAR - ID of the Eventhandler

*/
#include "script_component.hpp"
SCRIPT(addEventhandler);
_this params [
	["_eventName","",[""]],
	["_parameter",[],[[]]],
	["_namespace",missionnamespace,[missionnamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationnull]]
	];
CHECKRET((_eventName isEqualTo ""),false);

private _events = _namespace getVariable QGVAR(events);
CHECKRET((isNil "_events"),false);

private _eventIndex = _eventNames find _eventName;
CHECKRET((_eventIndex < 0),false);
{
	_parameter call _x;
} forEach ((_events select 1) select _eventIndex);
true;