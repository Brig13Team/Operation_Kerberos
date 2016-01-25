/*
    Author: Dorbedo
    
    Description:
        Post Init
    
*/
#include "script_component.hpp"
SCRIPT(postInit);
SCRIPT(XEH_POSTINIT);
CHECK(!hasInterface);

[QGVAR(playerspeaking), "OnSpeak", {
   If (_this select 1) then {_this call FUNC(isSpeaking);};
}, Player] call TFAR_fnc_addEventHandler;

