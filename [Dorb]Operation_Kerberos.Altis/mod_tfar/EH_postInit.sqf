/*
    Author: Dorbedo

    Description:
        Post Init

*/
#include "script_component.hpp"
CHECK(!hasInterface);
CHECK(!ACTIVEMOD_TFAR);

[QGVAR(playerspeaking), "OnSpeak", {
   If (_this select 1) then {_this call FUNC(isSpeaking);};
}, Player] call TFAR_fnc_addEventHandler;

[QGVAR(setWhispering),{[] call FUNC(setWhispering);}] call CBA_fnc_addEventHandler;
