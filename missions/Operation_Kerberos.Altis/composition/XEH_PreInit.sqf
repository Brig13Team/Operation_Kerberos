#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;
#include "XEH_PREP.hpp"
RECOMPILE_END;

ADDON = true;

[QGVAR(enableAI),{
    _this params ["_unit","_skilltype"];
    _unit enableAI _skilltype;
}] call CBA_fnc_addEventHandler;
