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
        tf_radio_channel_name = "Publicserver_Funk";
        tf_radio_channel_password = "TFAR";
        tf_west_radio_code = "_bluefor";
        tf_east_radio_code = "_bluefor";
        tf_guer_radio_code = "_bluefor";

        private _settings = call TFAR_fnc_generateSwSettings;
        _settings set [2,["100","110","120","130","140","150","160","170","180"]];
        tf_freq_west = +_settings;
        tf_freq_east = +_settings;
        tf_freq_guer = +_settings;
        private _settings = call TFAR_fnc_generateLrSettings;
        _settings set [2,["50","40","60","45","55","30","35","65","70","75"]];
        tf_freq_west_lr = +_settings;
        tf_freq_east_lr = +_settings;
        tf_freq_guer_lr = +_settings;
    }
] call CBA_fnc_addEventHandlerArgs;
