/*
    Author: Dorbedo

    Description:
        registers the HC

*/
#include "script_component.hpp"

[QGVAR(HCjoined),{_this call FUNC(HCconnect);}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["HandleDisconnect",{_this call FUNC(HCdisconnect);false;}];
