/*
    Author: Dorbedo

    Description:
        init
*/

#include "script_component.hpp"

GVARMAIN(playerside) = west;
enableSaving [false, false];
enableRadio false;


["Initialize"] call BIS_fnc_dynamicGroups;

If (isServer) then {
    setTimeMultiplier 2;
};
