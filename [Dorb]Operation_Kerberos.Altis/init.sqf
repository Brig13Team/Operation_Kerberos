/*
    Author: Dorbedo

    Description:
        init
*/

#include "script_component.hpp"

GVARMAIN(playerside) = west;
enableSaving [false, false];
enableRadio false;

If (isServer) then {
    setTimeMultiplier 2;
};
