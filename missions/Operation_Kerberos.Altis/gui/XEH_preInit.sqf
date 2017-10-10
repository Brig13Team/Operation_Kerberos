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
