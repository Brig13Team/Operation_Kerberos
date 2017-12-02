[
    QGVAR(fastArsenalLoading),
    "CHECKBOX",
    [localize LSTRING(fastArsenalLoading), localize LSTRING(fastArsenalLoading_TOOLTIP)],
    localize ELSTRING(main,name),
    true,
    0
] call cba_settings_fnc_init;

[
    QGVAR(debugArsenal),
    "CHECKBOX",
    [localize LSTRING(DEBUGARSENAL), localize LSTRING(DEBUGARSENAL_TOOLTIP)],
    localize ELSTRING(main,name),
    false,
    0
] call cba_settings_fnc_init;

[
    QGVAR(forceReload),
    "CHECKBOX",
    [localize LSTRING(forceReload), localize LSTRING(forceReload_TOOLTIP)],
    localize ELSTRING(main,name),
    false,
    0
] call cba_settings_fnc_init;
