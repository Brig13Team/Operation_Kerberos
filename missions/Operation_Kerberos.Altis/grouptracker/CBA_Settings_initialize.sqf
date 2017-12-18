[
    QGVAR(active),
    "CHECKBOX",
    LSTRING(active),
    "Operation Kerberos",
    true,
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(Intervall),
    "SLIDER",
    LSTRING(UpdateIntervall),
    "Operation Kerberos",
    [1, 10, 5, 1],
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(delayAmount),
    "SLIDER",
    LSTRING(delayedPositions),
    "Operation Kerberos",
    [1, 10, 3, 0],
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(AiIsVisible),
    "CHECKBOX",
    LSTRING(AiIsVisible),
    "Operation Kerberos",
    false,
    1
] call CBA_Settings_fnc_init;
