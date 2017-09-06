#include "script_component.hpp"


ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
GVAR(notifications) = HASH_CREATE;

ISNIL(timer_finish,-1);
ISNIL(timer_code,{});
ISNIL(timer_parameter,[]);

If (isServer) then {
    [QGVAR(setTimerServer),LINKFUNC(setTimerGlobal)] call CBA_fnc_localEvent;
};

