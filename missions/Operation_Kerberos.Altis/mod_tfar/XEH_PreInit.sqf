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

[
    "CBA_settingsInitialized",
    {
        If !(TF_ADDON_VERSION == "0.9.12") exitWith {};
        TF_no_auto_long_range_radio = true;
        TF_give_personal_radio_to_regular_soldier = false;
        TF_give_microdagr_to_soldier = false;
        TF_same_sw_frequencies_for_side = true;
        TF_same_lr_frequencies_for_side = true;
        TF_same_dd_frequencies_for_side = true;
        //tf_radio_channel_name = "";
        //tf_radio_channel_password = "";
        //tf_west_radio_code = "_bluefor";
        //tf_east_radio_code = "_opfor";
        //tf_guer_radio_code = "_independent";
        tf_freq_west = ["100","110","120","130","140","150","160","170","180"];
        tf_freq_east = ["144.6","200.1","205.7","316","352.9","392.5","491.5","505.7","84.9"];
        tf_freq_guer = ["165.6","192.1","248.2","258.7","343.1","384.1","439.6","472.9","53.7"];

        tf_freq_west_lr = ["30","35","40","45","50","55","60","65","70","75"];
        tf_freq_east_lr = ["31.7","44.2","45","49.4","55.3","56.2","57.2","58.6","64.6","70.4"];
        tf_freq_guer_lr = ["30.2","30.4","32.2","37.8","44.8","55.3","65.7","79.9","81","83.3"];
    }
] call CBA_fnc_addEventHandlerArgs;

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




