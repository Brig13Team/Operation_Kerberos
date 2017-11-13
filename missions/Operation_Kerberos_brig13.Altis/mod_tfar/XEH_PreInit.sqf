/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the preinit Eventhandler
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

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
        tf_radio_channel_name = "Publicserver_TFAR";
        tf_radio_channel_password = "TFAR";
        tf_west_radio_code = "_bluefor";
        tf_east_radio_code = "_bluefor";
        tf_guer_radio_code = "_bluefor";
        tf_freq_west = ["100","110","120","130","140","150","160","170","180"];
        tf_freq_east = ["100","110","120","130","140","150","160","170","180"];
        tf_freq_guer = ["100","110","120","130","140","150","160","170","180"];

        tf_freq_west_lr = ["30","35","40","45","50","55","60","65","70","75"];
        tf_freq_east_lr = ["30","35","40","45","50","55","60","65","70","75"];
        tf_freq_guer_lr = ["30","35","40","45","50","55","60","65","70","75"];
    }
] call CBA_fnc_addEventHandlerArgs;






