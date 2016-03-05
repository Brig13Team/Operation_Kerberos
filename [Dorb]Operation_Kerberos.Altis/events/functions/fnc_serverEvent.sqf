/*
    Author: Dorbedo

    Description:
        raises a serverEvent

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place of the Eventhandler
    

*/
#include "script_component.hpp"
If (isServer) exitWith {
    _this call FUNC(localEvent);
};

[
    _this,
    QUOTE(FUNC(__raiseEvent)),
    false,
    false,
    false
] call FUNC(remoteExec);