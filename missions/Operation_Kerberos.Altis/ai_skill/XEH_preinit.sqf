#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

ISNIL(active,true);
ISNIL(general,0.5);
ISNIL(accuracy,0.5);
ISNIL(handling,0.5);
ISNIL(spotting,0.5);

["AllVehicles", "init", LINKFUNC(setSkill), true, [], true ] call CBA_fnc_addClassEventHandler;

[QGVAR(active), "CHECKBOX", LSTRING(active), "Operation Kerberos", true, 1] call CBA_Settings_fnc_init;
[QGVAR(general), "SLIDER", LSTRING(general), "Operation Kerberos", [0, 1, 0.5, 2], 1] call CBA_Settings_fnc_init;
[QGVAR(accuracy), "SLIDER", LSTRING(accuracy), "Operation Kerberos", [0, 1, 0.5, 2], 1] call CBA_Settings_fnc_init;
[QGVAR(handling), "SLIDER", LSTRING(handling), "Operation Kerberos", [0, 1, 0.5, 2], 1] call CBA_Settings_fnc_init;
[QGVAR(spotting), "SLIDER", LSTRING(spotting), "Operation Kerberos", [0, 1, 0.5, 2], 1] call CBA_Settings_fnc_init;

[QGVAR(setSkill), LINKFUNC(setSkill)] call CBA_fnc_addEventhandler;
[
    QGVAR(setSkillGlobal),
    {
        If (!isServer) exitWith {};
        {
            [QGVAR(setSkill), [_x] ,_x] call CBA_fnc_targetEvent;
            nil
        } count allUnits;
    }
] call CBA_fnc_addEventhandler;
