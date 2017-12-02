[
    QGVAR(active),
    "CHECKBOX",
    LSTRING(active),
    "Task Force Arrowhead Radio",
    true,
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(Intervall),
    "SLIDER",
    LSTRING(UpdateIntervall),
    "Task Force Arrowhead Radio",
    [1, 10, 5, 1],
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(delayAmount),
    "SLIDER",
    LSTRING(delayedPositions),
    "Task Force Arrowhead Radio",
    [1, 10, 3, 0],
    1
] call CBA_Settings_fnc_init;
[
    QGVAR(AiIsVisible),
    "CHECKBOX",
    LSTRING(AiIsVisible),
    "Task Force Arrowhead Radio",
    false,
    1
] call CBA_Settings_fnc_init;
