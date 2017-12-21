[
    QGVAR(forceReload),
    "CHECKBOX",
    [LSTRING(forceReload), LSTRING(forceReload_tooltip)],
    "Operation Kerberos",
    false,
    2
] call cba_settings_fnc_init;

[
    QGVAR(fastArsenalLoading),
    "CHECKBOX",
    [LSTRING(fastArsenalLoading), LSTRING(fastArsenalLoading_tooltip)],
    "Operation Kerberos",
    false,
    2
] call cba_settings_fnc_init;

[
    QGVAR(level),
    "LIST",
    LSTRING(restriction),
    "Operation Kerberos",
    [[0, 1, 2, 3], [LSTRING(fullArsenal), LSTRING(Blacklist), LSTRING(SideGearOnly), LSTRING(SideOnly)], 2],
    1
] call cba_settings_fnc_init;

[
    QGVAR(allowedradius),
    "SLIDER",
    LSTRING(allowedradius),
    "Operation Kerberos",
    [5, 100, 25, 1],
    1
] call CBA_Settings_fnc_init;
