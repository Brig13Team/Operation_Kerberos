/*
    Author: Dorbedo

    Description:
        raises an GlobalEvent

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place of the Eventhandler
    

*/
#include "script_component.hpp"
[
    _this,
    QUOTE(FUNC(__raiseEvent)),
    true,
    false,
    false
] call FUNC(remoteExec);
_this call FUNC(localEvent);