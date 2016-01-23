/*
    Author: Dorbedo

    Description:
        add an Eventhandler

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : STRING/CODE - the code of the Eventhandler
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
    Returns:
        SCALAR - ID of the Eventhandler

*/
#include "script_component.hpp"
SCRIPT(addEventhandler);
_this params [
    ["_eventName","",[""]],
    ["_code","",["",{}]],
    ["_namespace",missionnamespace,[missionnamespace,uiNamespace,parsingNamespace,objNull,grpNull,taskNull,locationnull]]
    ];
CHECKRET((_eventName isEqualTo ""),-1);
If (IS_STRING(_code)) then {
    _code = compile _code;
};

private _events = _namespace getVariable QGVAR(events);
If (isNil "_events") then {
    _events = [[],[]];
};
private _eventNames = _events select 0;
private _eventFunctionsArray = [];
private _eventIndex = _eventNames find _eventName;

If (_eventIndex != -1) then {
    _eventFunctionsArray = (_events select 1) select _eventIndex;
}else{
    _eventIndex = count _events;
    _eventNames set [_eventIndex,_eventName];
};
private _return = _eventFunctionsArray pushBack _code;
(_events select 1) set [_eventIndex,_eventFunctionsArray];
_namespace setVariable [QGVAR(events),_events];

_return;
