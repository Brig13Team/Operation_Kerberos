/*
    Author: Dorbedo

*/
#include "script_component.hpp"

[{
    while {((count GVAR(waitAndExecArray)) > 0) && {((GVAR(waitAndExecArray) select 0) select 0) <= CBA_missionTime}} do {
        private _entry = GVAR(waitAndExecArray) deleteAt 0;
        (_entry select 2) call (_entry select 1);
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

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