//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

[QGVAR(delete),FUNC(delete)] call CBA_fnc_addEventHandler;
[QGVAR(setPylonLoadOut),
    params ["_aircraft", "_pylon", ["_ammo", "", [""]], ["_forced", true, [true]], ["_turret", [], [[]]]];
    _aircraft setPylonLoadOut [_pylon, _ammo, _forced, _turret];
] call CBA_fnc_addEventHandler;
