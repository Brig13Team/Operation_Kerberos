/*
    Author: Dorbedo

    Description:
        raises a serverEvent

    Parameter(s):
        0 : STRING - Name of the Eventhandler
        1 : ARRAY - Parameter for the Event
    (optional)
        2 : MISSIONNAMESPACE(default)/UINAMESPACE/PARSINGNAMESPACE/OBJECT/GROUP/TASK/LOCATION - Place to save the Eventhandler
    Returns:
        SCALAR - ID of the Eventhandler

*/
#include "script_component.hpp"
If (!isServer) then {
    [
        QUOTE(_this call FUNC(localEvent)),
        _this,
        0,
        false
    ] call FUNC(GlobalExec);
}else{
    _this call FUNC(localEvent);
};