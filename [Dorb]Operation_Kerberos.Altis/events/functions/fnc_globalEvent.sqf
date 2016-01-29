/*
    Author: Dorbedo

    Description:
        raises an GlobalEvent

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
    Returns:
        SCALAR - ID of the Eventhandler

*/
#include "script_component.hpp"
[
    QUOTE(_this call FUNC(localEvent)),
    _this,
    -2,
    false
] call FUNC(GlobalExec);
_this call FUNC(localEvent);