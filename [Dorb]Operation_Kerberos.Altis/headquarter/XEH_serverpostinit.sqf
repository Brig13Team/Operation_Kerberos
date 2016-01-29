/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"
SCRIPT(XEH_SERVERPOSTINIT);

["medical_onUnconscious", {
    _this params ["_unit", "_status"];
    if ((isplayer _unit)&&(_status)) then {
        [_unit] call FUNC(player_unconscious);
    };
}] call ace_common_fnc_addEventHandler;



