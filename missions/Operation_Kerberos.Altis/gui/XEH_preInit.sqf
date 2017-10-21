#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;
#include "XEH_PREP.hpp"
RECOMPILE_END;

ADDON = true;

GVAR(msg_waiting) = [];
GVAR(msg_cur) = [];
GVAR(blur_arr) = [];
GVAR(notifications) = HASH_CREATE;
GVAR(animBttns) = [];

[QGVAR(message), LINKFUNC(message)] call CBA_fnc_addEventHandler;

ISNIL(timer_finish,-1);
ISNIL(timer_code,{});
ISNIL(timer_parameter,[]);

If (isServer) then {
    [QGVAR(setTimerServer),LINKFUNC(setTimerGlobal)] call CBA_fnc_localEvent;
};

