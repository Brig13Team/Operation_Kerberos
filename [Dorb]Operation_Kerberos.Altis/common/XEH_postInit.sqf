/*
    Author: Dorbedo

*/
#include "script_component.hpp"

[
    {
        CHECK(GVAR(setVarSyncArray) isEqualTo [])
        private _temp = GVAR(setVarSyncArray);
        GVAR(setVarSyncArray) = [];
        {
            (_x select 2) setVariable [(_x select 0),(_x select 1),(_x select 3)];
        }forEach _temp;
    },
    1,
    []
] call CBA_fnc_addPerFrameHandler;
