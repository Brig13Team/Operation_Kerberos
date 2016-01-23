
#include "script_component.hpp"

[{
    private ["_entry"];
    while {((count GVAR(waitAndExecArray)) > 0) && {((GVAR(waitAndExecArray) select 0) select 0) <= diag_tickTime}} do {
        _entry = GVAR(waitAndExecArray) deleteAt 0;
        (_entry select 2) call (_entry select 1);
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;
