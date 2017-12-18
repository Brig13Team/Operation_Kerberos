/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the preInit Eventhandler
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

#include "settings.sqf"

If (hasInterface) then {
    [
        QGVAR(activateJammer),
        {
            If (isNil QGVAR(jammerClientHandler)) then {
                GVAR(jammerClientHandler) = [
                    {
                        if ((missionNamespace getVariable [QGVAR(jammer), []]) isEqualTo []) then {
                            GVAR(jammerClientHandler) = nil;
                            [_this select 1] call CBA_fnc_removePerFrameHandler;
                            [TFAR_currentUnit, false] call FUNC(disableTFAR);
                            [player, false] call FUNC(disableTFAR);
                        };
                        If ([TFAR_currentUnit] call FUNC(jammer_isActive)) then {
                            [TFAR_currentUnit, true] call FUNC(disableTFAR);
                        } else {
                            [TFAR_currentUnit, false] call FUNC(disableTFAR);
                        };
                    },
                    1
                ] call CBA_fnc_addPerFrameHandler;
            };
        }
    ] call CBA_fnc_addEventhandler;
    [QGVAR(activateJammer)] call CBA_fnc_localEvent;
};

If (isServer) then {
    [QGVAR(addJammer), LINKFUNC(jammer_add)] call CBA_fnc_addEventHandler;
    [QGVAR(removeJammer), LINKFUNC(jammer_remove)] call CBA_fnc_addEventHandler;
};

[
    QGVAR(AICanHearPlayer),
    "CHECKBOX",
    LSTRING(AICanHearPlayer),
    "Operation Kerberos",
    true,
    1,
    FUNC(onSettingChanged)
] call CBA_Settings_fnc_init;
