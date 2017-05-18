/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

["Initialize"] call BIS_fnc_dynamicGroups;

EGVAR(player,whitelistenabled) = true;
["pilotcheck",LINKFUNC(onGetIn)] call CBA_fnc_addEventHandler;
