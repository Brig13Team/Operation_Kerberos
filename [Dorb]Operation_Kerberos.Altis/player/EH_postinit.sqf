/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

["Initialize"] call BIS_fnc_dynamicGroups;

["pilotcheck",LINKFUNC(onGetIn)] call CBA_fnc_addEventHandler;
