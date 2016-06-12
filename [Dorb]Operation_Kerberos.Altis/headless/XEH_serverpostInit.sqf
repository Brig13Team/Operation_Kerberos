/*
    Author: Dorbedo
    
    Description:
        registers the HC

*/
#include "script_component.hpp"

[GVAR(HCjoined),{_this call FUNC(HCconnect);}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["HandleDisconnect",{_this call FUNC(HCdisconnect)}];
