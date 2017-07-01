#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

[QGVAR(delete),FUNC(delete)] call CBA_fnc_addEventHandler;
