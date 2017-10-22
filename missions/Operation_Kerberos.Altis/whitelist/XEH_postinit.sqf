/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

EGVAR(player,whitelistenabled) = true;
["pilotcheck",LINKFUNC(onGetIn)] call CBA_fnc_addEventHandler;
