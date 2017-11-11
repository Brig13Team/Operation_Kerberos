/*
 * Author: Dorbedo
 * asrai3 settings
 *
 */
#include "script_component.hpp"

if !(isServer) exitWith {};

["CBA_beforeSettingsInitialized", {
    ["CBA_settings_setSettingMission", ["asr_ai3_main_setskills",true,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_teamsuperai",false,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_seekcover",true,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_usebuildings",0.9,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_getinweapons",0.75,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_rearm",0,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_rearm_mags",0,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_rearm_fak",0,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_radiorange",0,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_rrdelaymin",5,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_rrdelayplus",10,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_packNVG",true,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_pgaistamina",0,true]] call CBA_fnc_localEvent;
    ["CBA_settings_setSettingMission", ["asr_ai3_main_onteamswitchleader",false,true]] call CBA_fnc_localEvent;

    ["CBA_beforeSettingsInitialized",_thisId] call CBA_fnc_removeEventHandler;
}] call CBA_fnc_addEventHandlerArgs;
