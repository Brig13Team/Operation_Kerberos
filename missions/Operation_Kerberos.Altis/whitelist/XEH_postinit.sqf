/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

EGVAR(player,whitelistenabled) = true;
["pilotcheck",LINKFUNC(onGetIn)] call CBA_fnc_addEventHandler;
