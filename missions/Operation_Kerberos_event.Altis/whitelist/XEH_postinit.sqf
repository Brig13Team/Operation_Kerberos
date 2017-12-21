/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

EGVAR(player,whitelistenabled) = false;
["pilotcheck",LINKFUNC(onGetIn)] call CBA_fnc_addEventHandler;
